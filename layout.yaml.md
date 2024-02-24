---
geometry:
 - paperwidth=5.5in
 - paperheight=8.5in
 - bottom=0.5in
 - top=0.5in
 - left=0.5in
 - right=0.5in

mainfont: Retni Sans

colorlinks: true

subparagraph: true

classoption:
 - twoside

header-includes:
- |
  ```{=latex}
  \usepackage{hyperref}
  \usepackage{titlesec}
  \newcommand{\sectionbreak}{\clearpage}
  \usepackage{fancyhdr}
  \pagestyle{fancy}
  \fancyhead{}
  \renewcommand{\headrule}{}
  \fancyfoot[CO,CE]{ \href{https://github.com/davemenninger/recipes}{https://github.com/davemenninger/recipes}}
  \fancyfoot[RO,LE]{\thepage}
  ```
---
