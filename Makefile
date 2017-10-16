pdf:
	@sed 1,7d README.rst > README.tmp.rst
	@pandoc -o README.pdf README.tmp.rst --toc --toc-depth=2 --number-sections \
	--dpi=600 --latex-engine=xelatex -V links-as-notes -V lot -V lof \
	-V mainfont="DejaVu Sans" -V monofont="Liberation Mono" \
	-V sansfont="DejaVu Sans" -V geometry:margin=15mm
	@rm README.tmp.rst
