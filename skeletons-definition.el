;;; package --- Summary
;;; Commentary:
;;; Code:

(define-skeleton presentation-skeleton
  "Inserts a beamer presentation skeleton into current buffer.
    This only makes sense for empty buffers."
  "Start:"
  "\\documentclass[9pt]{beamer}\n\n"
  "\\usepackage[english]{babel}\n"
  "\\usepackage[latin9]{inputenc}\n"
  "\\usepackage{graphicx,amsmath,amsfonts,float,times,tikz}\n"
  "\\usepackage{caption}\n"
  "\\usepackage{booktabs}\n"
  "\\usepackage[font=scriptsize]{subcaption}\n"
  "\\usepackage[T1]{fontenc}\n"
  "\\usetheme{Boadilla}\n\n"
  "\\makeatletter\n"
  "\\setbeamercovered{transparent}\n\n"
  "\\title[MonoJet Meeting]{" _ "}\n\n\n"
  "\\author[G.~Bertoli]{\\textbf{G.~Bertoli\\inst{1}} \\and C.~Clement\\inst{1}}\n\n"
  "\\institute[Stockholm University]{\\inst{1} Stockholm University \\\\ Physics Department}\n\n"
  "\\date[12 Jan 2015]{12 January 2015}\n\n"
  "\\pgfdeclareimage[height=1.0cm]{stockholm-logo}{/home/drkg4b/documenti/PhD/presentations/logo}\n"
  "\\logo{\pgfuseimage{stockholm-logo}}\n\n"
  "\\AtBeginSubsection[]{\n"
  "  \\begin{frame}<beamer>{Outline}\n"
  "    \\tableofcontents[currentsection,currentsubsection]\n"
  "  \\end{frame}\n"
  "}\n\n"
  "\\newcommand*{\\ud}{\\mathrm{d}}\n"
  "\\newcommand*{\\tikzmark}[1]{\\tikz[overlay,remember picture] \\node (#1) {};}\n"
  "\\newcommand*{\\met}{E_\\mathrm{\\, T}^\\mathrm{\\, miss}}"
  "\\newcommand*{\\md}{\\mathrm{M}_\\mathrm{\\, D}}"
  "\\newcommand*{\\ifb}{fb^{-1}}"
  "\\usetikzlibrary{shapes}\n"
  "\\usetikzlibrary{calc}\n\n"
  "\\graphicspath{{images/}}\n\n"
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
