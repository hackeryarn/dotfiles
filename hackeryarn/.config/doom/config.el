;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Base doom config

(setq user-full-name "Artem Chernyak"
      user-mail-address "artemchernyak@gmail.com")
(setq doom-theme 'doom-solarized-light)
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 18))
(setq display-line-numbers-type t)
(setq comint-prompt-read-only nil)
(setq-default enable-local-variables t)
(after! deft
  (setq deft-recursive t)
  (setq deft-directory "~/org"))
(after! ispell
  (setq ispell-dictionary "en"))
(setq org-directory "~/org/")
(after! org
  (add-hook! 'org-mode-hook 'org-fragtog-mode)
  (add-hook! 'org-mode-hook
    (add-hook 'after-save-hook 'org-babel-tangle nil 'local))
  (setq org-agenda-todo-ignore-scheduled 'future)
  (setq org-agenda-span 3)
  (setq org-agenda-custom-commands
        '(("n" "Daily tasks"
           ((agenda "" nil)
            (todo "STRT" nil)
            (todo "LOOP" nil)
            (todo "TODO" nil)
            (todo "WAIT" nil)
            (todo "HOLD" nil))
           nil)
          ("i" "IDEA"
           ((agenda "" nil)
            (todo "IDEA" nil)))))
  (push '("i" "Idea" entry
          (file+headline +org-capture-todo-file "Inbox")
          "* IDEA %?\n%i\n%a" :prepend t)
        org-capture-templates))
(after! circe
  (set-irc-server! "irc.libera.chat"
    `(:tls t
      :port 6697
      :nick "hackeryarn"
      :sasl-username "hackeryarn"
      :sasl-password (lambda (&rest _) (+pass-get-secret "web.libera.chat"))
      :channels ("#emacs" "#scheme" "#guix"))))

;;; General mode configs

(after! evil
  (setq evil-escape-key-sequence "fd")
  (setq evil-escape-key-sequence "fd")
  (evil-global-set-key 'insert (kbd "C-S-v") 'evil-paste-before))

(after! flycheck
  (flycheck-remove-next-checker 'python-flake8 'python-pylint)
  (flycheck-remove-next-checker 'python-flake8 'python-mypy))

(after! format-all
  (advice-add 'format-all-buffer :around #'envrc-propagate-environment)
  (set-formatter! 'autopep8 "autopep8 -" :modes '(python-mode)))

(after! lsp-mode
  (setq +format-with-lsp nil))

(after! yasnippet
  (add-to-list 'yas-snippet-dirs "~/src/hackeryarn/guix/etc/snippets"))

(after! projectile-mode

  (setq projectile-indexing-method 'hybrid))

;;; Language mode configs

(after! esh-mode
  (map! :map eshell-mode-map
        :i "C-c C-c" #'eshell-interrupt-process
        :i "<up>" #'eshell-previous-matching-input-from-input
        :i "<down>" #'eshell-next-matching-input-from-input))
(after! python
  (setq-hook! 'python-mode-hook +format-with 'autopep8)
  (add-hook! 'python-mode-hook
    (add-hook 'before-save-hook 'py-isort-before-save)
    (add-hook 'before-save-hook '+format/buffer))
  (setq py-isort-options '("--profile=django")))
(after! cider
  (cider-register-cljs-repl-type
   'bro
   "(do (user/run)
      (user/browser-repl))"))
(after! racket
  (add-hook 'racket-mode-hook #'racket-xp-mode))

(after! pollen-mode
  (add-hook 'pollen-mode-hook #'spell-fu-mode))
(after! geiser-guile
  (add-to-list 'geiser-guile-load-path "~/src/hackeryarn/guix"))

;;; Helper functions

(load-file "~/src/hackeryarn/guix/etc/copyright.el")
(setq copyright-names-regexp
      (format "%s <%s>" user-full-name user-mail-address))
(setq +drn/bin-path "~/common-lisp/daily-reading-notes/daily-reading-notes")

(defun +drn/new-post ()
  (interactive)
  (let ((dir (projectile-project-root)))
    (find-file (shell-command-to-string
                (format "%s new-post %s" +drn/bin-path dir)))
    (goto-char (point-min))
    (forward-line 5)))

(defun +drn/new-book ()
  (interactive)
  (let ((dir (projectile-project-root))
        (title (read-string "Enter book title: ")))
    (find-file (shell-command-to-string
                (format "%s new-book %s '%s'" +drn/bin-path dir title)))
    (goto-char (point-min))
    (forward-line 5)))
(defun setup-bro ()
  (interactive)
  (+workspace-switch "bro" t)
  (find-file "~/src/horizon/bro/manage.py")
  (+eshell/toggle nil))
(defun setup-bro-clj ()
  (interactive)
  (+workspace-switch "clj" t)
  (find-file "~/src/horizon/bro/clj/project.clj")
  (cider-jack-in-cljs '(:cljs-repl-type bro)))
