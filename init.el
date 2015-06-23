;;; package --- Summary
;;; Commentary:
;;; Code:

;; /This/ file (~init.el~) that you are reading
;; should be in this folder
(add-to-list 'load-path "~/.emacs.d/")

;; Package Manager
;; See ~Cask~ file for its configuration
;; https://github.com/cask/cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Keeps ~Cask~ file in sync with the packages
;; that you install/uninstall via ~M-x list-packages~
;; https://github.com/rdallasgray/pallet
(require 'pallet)

;; Root directory
(setq root-dir (file-name-directory
                (or (buffer-file-name) load-file-name)))

;; See this link for explanation:
;; http://stackoverflow.com/questions/11127109/
;; emacs-24-package-system-initialization-problems/11140619#11140619
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  ;; do things after package initialization

  ;;
  ;; Color Theme
  ;;
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
  (load-theme 'zenburn t)

  ;; Smart parenteses matching
  (smartparens-global-mode t)
  )

;; Don't show startup screen
(setq inhibit-startup-screen t)

;; flx-ido completion system, recommended by Projectile
(require 'flx-ido)
(flx-ido-mode 1)
;; change it if you have a fast processor.
(setq flx-ido-threshhold 1000)
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)


;; Project management
(require 'ack-and-a-half)
(require 'projectile)
(projectile-global-mode)

;; Snippets
;; https://github.com/capitaomorte/yasnippet
(require 'yasnippet)
(yas-load-directory (concat root-dir "snippets"))
(yas-global-mode 1)

;; Python editing
(require 'elpy)
(elpy-enable)
(elpy-use-ipython)

;; See this link:
;; http://stackoverflow.com/questions/2079095/
;; how-to-modularize-an-emacs-configuration
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "mu4e-settings.el")
(load-user-file "skeletons-definition.el")
(load-user-file "globals.el")
(load-user-file "flycheck-settings.el")

(setq tramp-default-method "ssh")            ;activate ssh in emacs
(show-paren-mode 1)                          ;match parenteses
(tool-bar-mode -1)                           ;hide tool bar
(scroll-bar-mode -1)                         ;hide scroll bar
(setq column-number-mode t)                  ;display column number
(setq printer-name "hpa4")                   ;set default printer name
(setq-default left-fringe-width 10)
(setq-default right-fringe-width 0)

;;
;; Backup
;;
(setq backup-directory-alist `(("." . "~/.saves"))
      version-control t
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 5
      kept-old-versions 2)

;; Expand Region
(require 'expand-region)
(global-set-key (kbd "M-2") 'er/expand-region)

;; Prevents built in emacs pdf reader to interfere with mu4e attachments:
(require 'openwith) ;open files with external program

(setq openwith-associations '(("\\.pdf\\'" "okular" (file)))) ;use okular for pdf
(openwith-mode t)

;; prevent <openwith> from interfering with mail attachments
(require 'mm-util)

(add-to-list 'mm-inhibit-file-name-handlers 'openwith-file-handler)

;; Delete trailing spaces before saving:
(add-hook 'before-save-hook
          'delete-trailing-whitespace)

;; Auto complete
(ac-config-default)

;;
;;      AutoFill
;;
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 80)
;(setq comment-auto-fill-only-comments t)

;;
;;      Astyle
;;
(defun astyle-this-buffer (pmin pmax)
  (interactive "r")
  (shell-command-on-region pmin pmax
                           "astyle" ;; add options here...
                           (current-buffer) t
                           (get-buffer-create "*Astyle Errors*") t))

;; ;required by ac-math
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

;; (require 'ac-math)                           ;autocomplete for math environment in latex
;; (require 'ring+)                             ;required by doremi
;; (require 'doremi-cmd)                        ;doremi is to simulate the repeat key to loop over menus and other
;; (require 'flyspell-babel)                    ;to automatically switch flyspell to the correct language in a latex doc
;; (require 'ispell-multi)                      ;teach emacs to handle multi languages
;; (require 'cdlatex)                           ;enable fast completion for commands in latex


;; ;
;; ;   LaTeX
;; ;

;; (add-to-list 'ac-modes 'latex-mode)          ;make auto-complete aware of {{{latex-mode}}}
;; (setq ac-quick-help-delay 0.5)

;; (defun ac-latex-mode-setup ()                ;add ac-sources to default ac-sources
;;   (setq ac-sources
;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;                ac-sources))
;; )

;; (add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)

;; (setq TeX-PDF-mode t)                        ;latex compile directly in pdf
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
;; (add-hook 'LaTeX-mode-hook (lambda () (autopair-mode -1)))
;; (setq-default TeX-master nil)                            ; Ask for master file
;; (setq TeX-electric-sub-and-superscript t)                ; automatically insert braces before and after ^ _
;; (autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)      ;
;; (autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil) ; Autoload CDLaTeX
;; (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)             ;


;; ;
;; ;     REFTEX
;; ;

;; (autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
;; (autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
;; (autoload 'reftex-citation "reftex-cite" "Make citation" nil)
;; (autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)

;; (setq reftex-plug-into-AUCTeX t)               ;make auctex aware of reftex
;; (setq reftex-toc-split-windows-horizontally t) ;split windows vertically
;; (setq reftex-keep-temporary-buffers t)         ;open buffer for files belonging to a multifile doc
;; (setq reftex-bibpath-environment-variables
;;       '("/home/documenti/Tesi/Specialistica/tesi/"))



;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(TeX-PDF-mode t t)
;;  '(TeX-source-correlate-method (quote synctex))
;;  '(TeX-source-correlate-mode t)
;;  '(TeX-source-correlate-start-server t)
;;  '(TeX-view-program-list (quote (("okular" "okular --unique %o#src:%n%b"))))
;;  '(TeX-view-program-selection (quote ((output-pdf "okular") ((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Evince") (output-html "xdg-open"))))
;;  '(auth-source-save-behavior nil)
;;  '(custom-safe-themes (quote ("9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" default)))
;;  '(inhibit-startup-screen t)
;;  '(load-home-init-file t t)
;;  '(max-lisp-eval-depth 1000)
;;  '(max-specpdl-size 400)
;;  '(reftex-default-bibliography (quote ("/home/documenti/Tesi/Specialistica/tesi/bibliography.bib"))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


;; ;;(load "preview-latex.el" nil t t)

;; (setq minibuffer-max-depth nil)

;; ;
;; ; Color Theme
;; ;
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'zenburn t)

;; ;; (add-to-list 'load-path "/path/to/color-theme.el/file")
;; ;; (require 'color-theme)
;; ;; (eval-after-load "color-theme"
;; ;;   '(progn
;; ;;      (color-theme-initialize)
;; ;;      (color-theme-tty-dark)))

;; ;
;; ;      Autocomplete
;; ;

;; (add-to-list 'load-path "/home/drkg4b/.emacs.d/")
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "/home/drkg4b/.emacs.d/ac-dict")
;; (ac-config-default)
;; (setq ac-use-quick-help t)


;; ;
;; ;      Pymacs
;; ;

;; (load-file "/home/drkg4b/.emacs.d/emacs-for-python-master/epy-init.el")

;; ;
;; ;      Flycheck
;; ;

;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; (epy-setup-checker "pyflakes %f")

;; ;
;; ;      AutoFill
;; ;

;; (setq-default auto-fill-function 'do-auto-fill)
;; (setq-default fill-column 80)
;; ;(auto-fill-mode 1)
;; ;(setq comment-auto-fill-only-comments t)

;; ;
;; ;      AutoPair
;; ;

;; ;; (require 'autopair)

;; ;; (autopair-global-mode)


;; ;
;; ;      ORG Mode
;; ;

;; (require 'org-install)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-cc" 'org-capture)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (setq org-log-done t)
;; (setq org-mobile-directory "~/Dropbox/org")
;; (setq org-directory "~/Dropbox/org")
;; (setq org-default-notes-file "~/Dropbox/org/refile.org")
;; (setq org-agenda-files (list "~/Dropbox/org"))
;; (setq org-mobile-files (list "~/Dropbox/org"))
;; (add-hook 'org-mode-hook 'flyspell-mode)

;; ;; Capture templates for TODO tasks, Notes

;; (setq org-capture-templates
;;       (quote (("t" "todo" entry (file "~/Dropbox/org/refile.org")
;;                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
;; 	      ("n" "note" entry (file "~/Dropbox/org/refile.org")
;;                "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t))))

;; ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
;; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;;                                  (org-agenda-files :maxlevel . 9))))

;; ; Use full outline paths for refile targets - we file directly with IDO
;; (setq org-refile-use-outline-path t)

;; ; Targets complete directly with IDO
;; (setq org-outline-path-complete-in-steps nil)

;; ; Allow refile to create parent tasks with confirmation
;; (setq org-refile-allow-creating-parent-nodes (quote confirm))

;; ; Use IDO for both buffer and file completion and ido-everywhere to t
;; (setq org-completion-use-ido t)
;; (setq ido-everywhere t)
;; (setq ido-max-directory-size 100000)
;; (ido-mode (quote both))
;; ; Use the current window when visiting files and buffers with ido
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)

;; ;;;; Refile settings
;; ; Exclude DONE state tasks from refile targets
;; (defun bh/verify-refile-target ()
;;   "Exclude todo keywords with a done state from refile targets."
;;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))

;; (setq org-refile-target-verify-function 'bh/verify-refile-target)



(provide '.emacs)
;;; .emacs ends here
(put 'dired-find-alternate-file 'disabled nil)
