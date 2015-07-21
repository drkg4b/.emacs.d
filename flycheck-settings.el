;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Perhaps a more appropriate way to set these variables would be to use
;; M-x add-dir-local-variable RET c++-mode RET var_to_set RET path_to_include
(add-hook 'c++-mode-hook
          (lambda ()
	    (setq flycheck-gcc-standard-library "libc++")
	    (setq flycheck-gcc-language-standard "c++1y")))

;; Disable clang as default syntax checker for c++, this variable is buffer
;; local by default, need to use setq-default to change the global value
(setq-default flycheck-disabled-checkers '(c/c++-clang))

;; To help respecting google C++ code style, install flycheck-google-cpplint,
;; see https://github.com/flycheck/flycheck-google-cpplint
(eval-after-load 'flycheck
  '(progn
     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.'
     (flycheck-add-next-checker 'c/c++-gcc
				'(warning . c/c++-googlelint))))

(custom-set-variables
 '(flycheck-c/c++-googlelint-executable "/usr/local/bin/cpplint.py"))

;; Start google-c-style
(require 'google-c-style)

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(provide 'flycheck-settings)
;;; flycheck-settings.el ends here
