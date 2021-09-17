(define-module (udiskie-service)
  #:export (udiskie))

(use-modules ((oop goops) #:select (make))
             (shepherd service))

(define udiskie
  (make <service>
    #:provides '(udiskie)
    #:docstring "Runs `udiskie' with the tray option"
    #:start (make-forkexec-constructor
             '("/home/hackeryarn/.guix-profile/bin/udiskie" "--tray")
             #:log-file "/home/hackeryarn/log/udiskie.log")
    #:stop (make-kill-destructor)
    #:respawn? #t))
(register-services udiskie)
