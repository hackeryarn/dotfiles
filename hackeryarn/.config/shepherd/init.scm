;;; Load local modules
(add-to-load-path (string-append
                   (dirname (current-filename))
                   "/init.d"))

(use-modules (kanshi-service)
             (sway-service)
             (waybar-service)
             (udiskie-service))

(start kanshi)
(start sway)
(start waybar)
(start udiskie)

(action 'shepherd 'daemonize)
