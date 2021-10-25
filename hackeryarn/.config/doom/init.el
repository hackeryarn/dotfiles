;;; init.el -*- lexical-binding: t; -*-

(doom! :input
       
       :completion
       company
       (ivy +fuzzy +prescient +all-the-icons-ivy)
       :ui
       hl-todo
       modeline
       ophints
       (popup +defaults)
       vc-gutter
       vi-tilde-fringe
       workspaces
       deft
       doom
       doom-dashboard
       doom-quit
       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       (parinfer +rust)
       snippets
       :emacs
       dired
       electric
       undo
       vc
       :term
       eshell
       vterm
       :checkers
       syntax
       (spell +aspell)
       grammar
       :tools
       ansible
       direnv
       docker
       editorconfig
       (eval +overlay)
       lookup
       lsp
       magit
       (pass +auth)
       pdf
       rgb
       taskrunner
       :lang
       clojure
       common-lisp
       emacs-lisp
       (haskell +lsp)
       hy
       json
       javascript
       julia
       latex
       markdown
       nim
       nix
       (org +roam2)
       plantuml
       purescript
       (python +lsp +pyright)
       (racket +xp)
       rest
       (ruby +rails)
       (scheme
        +guile
        +mit
        +chez
        +gambit)
       sh
       web
       yaml
       pollen
       :email
       
       :app
       irc
       (rss +org)
       :config
       (default +bindings +smpartparens))
