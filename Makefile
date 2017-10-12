pdf:
	@pandoc -o README.pdf README.rst --latex-engine=xelatex --toc --toc-depth=2 --reference-links --number-sections -V mainfont="Liberation Serif" -V seriffont="Liberation Serif" -V monofont="Liberation Mono" -V sansfont="Liberation Sans"
