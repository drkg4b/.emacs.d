;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'c++-mode-hook
          (lambda ()
	    (setq flycheck-clang-standard-library "libc++")
	    (setq flycheck-clang-language-standard "c++1y")
	    (setq flycheck-clang-include-path
                           '("~/work/ATLAS/sw/MonoJetAnalysis/MiniReader_v1/trunk/MiniReader/MiniReader"))))

(provide 'flycheck-settings)
;;; flycheck-settings.el ends here
