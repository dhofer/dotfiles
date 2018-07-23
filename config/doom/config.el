;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-

;; themes
(setq doom-font (font-spec :family "Iosevka")
      doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-solarized-light t)
;; Enable custom neotree theme
(doom-themes-neotree-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(setq user-full-name "Daniel Hofer"
      user-mail-address "daniel@dhofer.com"

      +org-dir (expand-file-name "~/Dropbox/Org/")
      org-agenda-files '("~/Dropbox/Org/gtd/inbox.org"
                         "~/Dropbox/Org/gtd/gtd.org"
                         "~/Dropbox/Org/gtd/tickler.org")
      org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Dropbox/Org/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Dropbox/Org/gtd/tickler.org")
                               "* %i%? \n %U"))
      org-refile-targets '(("~/Dropbox/Org/gtd/gtd.org" :maxlevel . 3)
                           ("~/Dropbox/Org/gtd/someday.org" :level . 1)
                           ("~/Dropbox/Org/gtd/tickler.org" :maxlevel . 2))
      )

;; tools/magit
(after! magit-repos
  (setq magit-repository-directories
        (cl-loop for dir in (directory-files "~/Source" t "^[^.]" t)
                 if (file-directory-p dir)
                 nconc (cl-loop for subdir in (directory-files dir t "^[^.]" t)
                                if (and (file-directory-p subdir)
                                        (file-directory-p (expand-file-name ".git/" subdir)))
                                collect subdir))))
