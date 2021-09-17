;;; Load local modules
(add-to-load-path (string-append
                   (dirname (current-filename))
                   "/init.d"))

(use-modules (kanshi-service)
             (udiskie-service)
             (waybar-service))

(start kanshi)
(start udiskie)
(start waybar)

(action 'shepherd 'daemonize)
