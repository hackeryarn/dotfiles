(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload '(:with-user-abort :adopt) :silent t))

(defpackage :clean-backups
  (:use :cl)
  (:export :toplevel *ui*))

(in-package :clean-backups)

;;;; Configuration
(defparameter *path* "/run/media/backup/")

;;;; Errors
(define-condition user-error (error) ())

;;;; Functionality
(defun backups (machines)
  (loop for machine in machines
        nconc (uiop:subdirectories machine)))

(defun snapshots (backup trim)
  (funcall
   trim
   (sort (uiop:subdirectories backup) #'>
         :key (lambda (p)
                (parse-integer (first (last (pathname-directory p))))))))

(defun collect-snapshots (path)
  (let ((machines (uiop:subdirectories "snapshots/")))
    (loop for backup in (backups machines)
          nconc (loop for snapshot in (snapshots backup #'cddr)
                      collect (subseq (uiop:native-namestring snapshot)
                                      (length path))))))

(defun delete-subvolumes (snapshots)
  (loop for snapshot in snapshots
        for volume = (concatenate 'string snapshot "snapshot")
        do (uiop:run-program (list "btrfs" "subvolume" "delete" volume) :output t)))

(defun delete-directories (snapshots)
  (loop for snapshot in snapshots
        do (uiop:delete-directory-tree (pathname snapshot) :validate t)))

(defun clean-snapshots (path)
  (uiop:with-current-directory (path)
    (let ((snapshots (collect-snapshots path)))
      (delete-subvolumes snapshots)
      (delete-directories snapshots))))

;;;; Run
(defun run (path)
  (clean-snapshots path))

;;;; User Interface
(defmacro exit-on-ctrl-c (&body body)
  `(handler-case (with-user-abort:with-user-abort (progn ,@body))
     (with-user-abort:user-abort () (adopt:exit 130))))

(defparameter *help-text*
 "Cleans up extra snapshots generated by snap-sync.")
  
(defparameter *option-help*
  (adopt:make-option
   'help
   :long "help"
   :short #\h
   :help "display help information and exit"
   :reduce (constantly t)))

(defparameter *option-path*
  (adopt:make-option
   'path
   :parameter "PATH"
   :long "path"
   :short #\p
   :help "the path of the backup directory"
   :initial-value *path*
   :reduce #'adopt:last))

(adopt:defparameters (*option-debug* *option-no-debug*)
    (adopt:make-boolean-options
     'debug
     :long "debug"
     :short #\d
     :help "Enable the Lisp debugger."
     :help-no "Disable the Lisp debugger (the default)."))

(defparameter *ui*
  (adopt:make-interface
   :name "backup"
   :summary "a utility to cleanup snapshots"
   :usage "[OPTIONS]" 
   :help *help-text*
   :contents (list
              *option-help*
              *option-debug*
              *option-no-debug*
              (adopt:make-group 'clean-ptions
                                :title "Clean Options"
                                :options (list *option-path*)))))

(defun toplevel ()
  (sb-ext:disable-debugger)
  (exit-on-ctrl-c
    (multiple-value-bind (arguments options) (adopt:parse-options-or-exit *ui*)
      (declare (ignore arguments))
      (when (gethash 'debug options)
        (sb-ext:enable-debugger))
      (handler-case
          (cond
            ((gethash 'help options) (adopt:print-help-and-exit *ui*))
            (t (let ((path (gethash 'path options)))
                 (run path))))
        (user-error (e) (adopt:print-error-and-exit e))))))