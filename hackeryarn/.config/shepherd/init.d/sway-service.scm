(define-module (sway-service)
  #:export (sway))

(use-modules ((oop goops) #:select (make))
             (shepherd service))

(define sway
  (make <service>
    #:provides '(sway)
    #:docstring "Runs `sway' to start sway"
    #:start (make-forkexec-constructor
             '("dbus-run-session" "sway" "--debug")
             #:log-file (string-append (getenv "HOME")
                                       "/log/sway.log"))
    #:stop (make-kill-destructor)
    #:respawn? #t))
(register-services sway)
