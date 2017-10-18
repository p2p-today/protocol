pdf:
	@sed 1,7d README.rst > README.tmp.rst
	@./pandoc -o README.pdf README.tmp.rst --toc --toc-depth=2 --dpi=600 \
	--number-sections --pdf-engine=xelatex -V links-as-notes -V lot -V lof \
	-V mainfont="DejaVu Sans" -V monofont="Liberation Mono" \
	-V sansfont="DejaVu Sans" -V geometry:margin=15mm || echo \
	"download a pandoc nightly"
	@rm README.tmp.rst
