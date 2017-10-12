pdf:
	@pandoc -o README.pdf README.rst --toc --toc-depth=2 --number-sections \
	--dpi=600 -S -V links-as-notes -V lot -V lof \
	--latex-engine=xelatex -V mainfont="Liberation Serif" \
	-V monofont="Liberation Mono" -V sansfont="Liberation Sans"
