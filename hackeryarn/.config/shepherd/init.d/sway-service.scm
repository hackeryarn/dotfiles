(define-module (sway-service)
  #:export (sway))

(use-modules ((oop goops) #:select (make))
             (shepherd service))

(define sway
  (make <service>
    #:provides '(sway)
    #:docstring "Runs `sway' to start sway"
    #:start (make-forkexec-constructor
             '("/home/hackeryarn/.guix-profile/bin/dbus-run-session"
               "/home/hackeryarn/.guix-profile/bin/sway" "--debug")
             #:log-file "/home/hackeryarn/log/sway.log")
    #:stop (make-kill-destructor)
    #:respawn? #t))
(register-services sway)
