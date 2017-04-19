SHELL:=/bin/bash -O extglob

TEXS = thesis.tex abstract.tex acknowledgement.tex acronyms.tex CD.tex conclusion.tex declaration.tex introduction.tex SDP.tex

TEMPLATE = cmpthesis.cls cmpcover.sty

IMAGES = cmp.png lev.png

ALGS = self-concordant-function.tex analytic-center.tex path-follow.tex

GRAPHS_FILES = SDP_hyperPar SDP_hyperParSlice SDP_demo
GRAPHS_PDF = $(addsuffix .pdf, $(GRAPHS_FILES))
GRAPHS_TEX = $(addsuffix .tex, $(GRAPHS_FILES))
GRAPHS_EPS = $(addsuffix .eps, $(GRAPHS_FILES))
GRAPHS = $(GRAPHS_TEX) $(GRAPHS_PDF)

INTER = $(addprefix graphs/, $(GRAPHS_EPS))

.PHONY: all pdf fast clean
.SECONDEXPANSION:
.INTERMEDIATE: $$(INTER)

all: thesis.pdf

pdf: thesis.pdf

fast: $(TEXS) $(TEMPLATE) $$(addprefix images/, $(IMAGES)) $$(addprefix alg/, $(ALGS)) $$(addprefix graphs/, $(GRAPHS))
	sed -i 's/\eqB/\begin{eqnarray}/g' !(thesis).tex
	sed -i 's/\eqE/\end{eqnarray}/g' !(thesis).tex
	pdflatex thesis.tex

thesis.pdf: $(TEXS) citations.bib $(TEMPLATE) $$(addprefix images/, $(IMAGES)) $$(addprefix alg/, $(ALGS)) $$(addprefix graphs/, $(GRAPHS))
	sed -i 's/\eqB/\begin{eqnarray}/g' !(thesis).tex
	sed -i 's/\eqE/\end{eqnarray}/g' !(thesis).tex
	pdflatex thesis.tex
	makeglossaries thesis
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

graphs/%.pdf: graphs/%.eps
	ps2pdf -dEPSCrop graphs/$*.eps graphs/$*.pdf

graphs/%.tex graphs/%.eps: sources/graphs/%.gnuplot sources/graphs/%-*.dat
	gnuplot sources/graphs/$*.gnuplot

graphs/%.tex graphs/%.eps: sources/graphs/%.gnuplot
	gnuplot sources/graphs/$*.gnuplot

clean:
	-rm thesis.!(tex)
	-rm $(addprefix graphs/, $(GRAPHS))
