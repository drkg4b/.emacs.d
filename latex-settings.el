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

(provide 'latex-settings.el)
;;; latex-settings.el ends here
