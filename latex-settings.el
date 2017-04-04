;;; package --- Summary
;;; Commentary:
;;; Code:

;; Check http://www.gnu.org/software/auctex/manual/auctex.html#Quick-Start

;; To get support for many of the LaTeX packages, enable document parsing:
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; If you often use \include or \input, you should make AUCTeX aware of the
;; multi-file document structure:
(setq-default TeX-master nil)

;; To compile documents to PDF by default
(setq TeX-PDF-mode t)

;; To set okular as the default PDF viewer
(setq TeX-view-program-selection
      '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "okular %o")))

;; Require flyspell for latex mode
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Turn on RefTeX for AUCTeX,
;; http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; Make RefTeX interact with AUCTeX,
;; http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
(setq reftex-plug-into-AUCTeX t)

;; So that RefTeX also recognizes \addbibresource. Note that you
;; can't use $HOME in path for \addbibresource but that "~"
;; works.
(setq reftex-bibliography-commands '("bibliography" "nobibliography"
				     "addbibresource"))

;; Split windows vertically
(setq reftex-toc-split-windows-horizontally t)

;; Open buffer for files belonging to a multifile doc
(setq reftex-keep-temporary-buffers t)

(provide 'latex-settings.el)
;;; latex-settings.el ends here
