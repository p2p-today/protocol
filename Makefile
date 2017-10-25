size ?= letter

pdf:
	@echo "Generating a(n) $(size) pdf"
	@sed 1,7d README.rst > .README.rst
	@./pandoc -o README.$(size).pdf .README.rst --toc --toc-depth=2 --dpi=600 \
	--number-sections --pdf-engine=xelatex --include-in-header preamble.tex \
	-V links-as-notes -V mainfont="DejaVu Sans" -V monofont="Liberation Mono" \
	-V sansfont="DejaVu Sans" -V geometry:margin=15mm -V papersize=$(size) || \
	echo "download a pandoc nightly"
	@rm .README.rst

letter:
	@$(MAKE) pdf size=letter

legal:
	@$(MAKE) pdf size=legal

A4:
	@$(MAKE) pdf size=A4

all: A4 letter legal
