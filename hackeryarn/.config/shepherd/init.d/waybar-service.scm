(define-module (waybar-service)
  #:export (waybar))

(use-modules ((oop goops) #:select (make))
             (shepherd service))

(define waybar
  (make <service>
    #:provides '(waybar)
    #:docstring "Runs `waybar' to create a sway bar"
    #:start (make-forkexec-constructor
             '("/home/hackeryarn/.guix-profile/bin/waybar")
             #:log-file "/home/hackeryarn/log/waybar.log")
    #:stop (make-kill-destructor)
    #:respawn? #t))
(register-services waybar)
