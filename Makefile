size ?= letter

pdf:
	@sed 1,7d README.rst > README.tmp.rst
	@./pandoc -o README.$(size).pdf README.tmp.rst --toc --toc-depth=2 --dpi=600 \
	--number-sections --pdf-engine=xelatex -V links-as-notes -V lot -V lof \
	-V mainfont="DejaVu Sans" -V monofont="Liberation Mono" \
	-V sansfont="DejaVu Sans" -V geometry:margin=15mm -V papersize=$(size) || \
	echo "download a pandoc nightly"
	@rm README.tmp.rst

letter:
	@$(MAKE) pdf size=letter

legal:
	@$(MAKE) pdf size=legal

A4:
	@$(MAKE) pdf size=A4

all: A4 letter legal
