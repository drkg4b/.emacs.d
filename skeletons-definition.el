;;; package --- Summary
;;; Commentary:
;;; Code:

(define-skeleton presentation-skeleton
  "Inserts a beamer presentation skeleton into current buffer.
    This only makes sense for empty buffers."
  "Start:"
  "\\documentclass[10pt]{beamer}\n\n"
  "\\usepackage[english]{babel}\n"
  "\\usepackage[latin9]{inputenc}\n"
  "\\usepackage{graphicx,amsmath,amsfonts,float,times,tikz}\n"
  "\\usepackage{caption}\n"
  "\\usepackage[font=scriptsize]{subcaption}\n"
  "\\usepackage[T1]{fontenc}\n"
  "\\usetheme{Boadilla}\n\n"
  "\\makeatletter\n"
  "\\setbeamercovered{transparent}\n\n"
  "\\title[MonoJet Meeting]{" _ "}\n\n\n"
  "\\author[Gabriele~Bertoli]{G.~Bertoli\\inst{1}}\n\n"
  "\\institute[Stockholm University]{\\inst{1} Stockholm University \\\\ Physics Department}\n\n"
  "\\date[12 Jan 2015]{12 January 2015}\n\n"
  "\\pgfdeclareimage[height=1.0cm]{stockholm-logo}{/home/drkg4b/documenti/PhD/presentations/logo}\n"
  "\\logo{\pgfuseimage{stockholm-logo}}\n\n"
  "\\AtBeginSubsection[]{\n"
  "  \\begin{frame}<beamer>{Outline}\n"
  "    \\tableofcontents[currentsection,currentsubsection]\n"
  "  \\end{frame}\n"
  "}\n\n"
  "\\newcommand{\\ud}{\\mathrm{d}}\n"
  "\\newcommand{\\met}{\\ensuremath{{\\not\\mathrel{E}}_T}}\n"
  "\\newcommand{\\tikzmark}[1]{\\tikz[overlay,remember picture] \\node (#1) {};}\n"
  "\\usetikzlibrary{shapes}\n"
  "\\usetikzlibrary{calc}\n"
  "%\\setbeamertemplate{itemize item}{-}\n\n\n"
  "\\begin{document}\n"
  "\\begin{frame}\n"
  "  \\titlepage\n"
  "\\end{frame}\n"
  "\\end{document}\n")

(define-skeleton function-comment
  "Insert comment pattern for functions."
  "Start:"
  "////////////////////////////////////////////////////////////////////////////////\n"
  "////" _ " \n"
  "////////////////////////////////////////////////////////////////////////////////")

(provide 'skeletons-definition)
;;; skeletons-definition.el ends here
