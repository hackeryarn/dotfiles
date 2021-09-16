;;; Load local modules
(add-to-load-path (string-append
                   (dirname (current-filename))
                   "/init.d"))

(use-modules (udiskie-service)
             (kanshi-service)
             (sway-service)
             (waybar-service))

(start udiskie)
(start kanshi)
(start sway)
(start waybar)

(action 'shepherd 'daemonize)
