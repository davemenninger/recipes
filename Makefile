.PHONY: clean open pdf html all help deps

metadata_files = metadata.yaml.md layout.yaml.md
source_files = $(wildcard pages/*.md)
pdf_file = cookbook.pdf
html_file = cookbook.html

pdf: ## Generates output.pdf
pdf: $(pdf_file)

html: ## Generates output.html
html: $(html_file)

all: pdf html ## Generates both HTML and PDF

deps:
	sudo apt install \
	pandoc \
	librsvg2-bin \
	texlive-xetex \
	texlive-luatex \
	texlive-latex-extra

# * SVG content in PDF output requires librsvg2-bin.
# * YAML metadata in TeX-related output requires texlive-latex-extra.
# * *.hs filters not set executable requires ghc.
# * *.js filters not set executable requires nodejs \
# * *.php filters not set executable requires php \
# * *.pl filters not set executable requires perl \
# * *.py filters not set executable requires python \
# * *.rb filters not set executable requires ruby \
# * *.r filters not set executable requires r-base-core \
# * LaTeX output, and PDF output via PDFLaTeX \
# require texlive-latex-recommended \
# * XeLaTeX output, and PDF output via XeLaTeX, require texlive-xetex \
# * LuaTeX output, and PDF output via LuaTeX, require texlive-luatex \
# * ConTeXt output, and PDF output via ConTeXt, require context \
# * PDF output via wkhtmltopdf requires wkhtmltopdf \
# * Roff man and roff ms output, and PDF output via roff ms \
# require groff \
# * MathJax-rendered equations require libjs-mathjax \
# * KaTeX-rendered equations require node-katex \
# * option --csl may use styles in citation-style-language-styles

$(pdf_file): $(metadata_files) $(source_files)
	pandoc -s \
		--resource-path=.:pages:assets \
		--pdf-engine=xelatex \
		--table-of-contents \
		--toc-depth=1 \
		$(metadata_files) $(source_files) \
		-o $(pdf_file)

$(html_file): $(metadata_files) $(source_files)
	pandoc -s \
		--resource-path=.:pages:assets \
		--embed-resources=true \
		--css=path/to/custom.css \
		--toc \
		--lua-filter=lua/anchor-links.lua \
		$(metadata_files) $(source_files) \
		-o $(html_file)

clean: ## Deletes generated HTML and PDF files
	rm -f $(pdf_file) $(html_file)

open: ## opens the PDF with your default viewer using the `open` command
open: $(pdf_file)
	open $(pdf_file)

help: ## Shows this help.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

