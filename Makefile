.PHONY: all pdf fast clean

all: thesis.pdf

pdf: thesis.pdf

fast: thesis.tex abstract.tex acknowledgement.tex acronyms.tex CD.tex conclusion.tex declaration.tex introduction.tex cmpthesis.cls cmpcover.sty
	pdflatex thesis.tex

thesis.pdf: thesis.tex abstract.tex acknowledgement.tex acronyms.tex CD.tex conclusion.tex declaration.tex introduction.tex citations.bib cmpthesis.cls cmpcover.sty images/cmp.png images/lev.png
	pdflatex thesis.tex
	makeglossaries thesis
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

clean:
	-rm thesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
