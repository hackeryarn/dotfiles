(define-module (kanshi-service)
  #:export (kanshi))

(use-modules ((oop goops) #:select (make))
             (shepherd service))

(define kanshi
  (make <service>
    #:provides '(kanshi)
    #:docstring "Runs `kanshi' to manage displays"
    #:start (make-forkexec-constructor
             '("/home/hackeryarn/.guix-profile/bin/kanshi")
             #:log-file "/home/hackeryarn/log/kanshi.log")
    #:stop (make-kill-destructor)
    #:respawn? #t))
(register-services kanshi)
