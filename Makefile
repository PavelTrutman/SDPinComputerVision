SHELL:=/bin/bash -O extglob

# Set variable AllowGenerateData to "TRUE" if you want to allow to data regeneration
AllowGenerateData ?= FALSE

# fast compiling
Fast ?= FALSE

TEXS = thesis.tex abstract.tex acknowledgement.tex acronyms.tex CD.tex conclusion.tex declaration.tex introduction.tex SDP.tex

TEMPLATE = cmpthesis.cls cmpcover.sty

IMAGES = cmp.png lev.png

ALGS = self-concordant-function.tex analytic-center.tex path-follow.tex

GRAPHS_FILES = SDP_hyperPar SDP_hyperParSlice SDP_demo SDP_barrier SDP_performance
GRAPHS_PDF = $(addsuffix .pdf, $(GRAPHS_FILES))
GRAPHS_TEX = $(addsuffix .tex, $(GRAPHS_FILES))
GRAPHS_EPS = $(addsuffix .eps, $(GRAPHS_FILES))
GRAPHS = $(GRAPHS_TEX) $(GRAPHS_PDF)

DRAWINGS_FILES = SDP_problem
DRAWINGS_PDF = $(addsuffix .pdf, $(DRAWINGS_FILES))

TABLES_FILES = SDP_performance
TABLES_TEXS = $(addsuffix .tex, $(TABLES_FILES))

MACROS_FILES = SDP_performance
MACROS_TEXS = $(addsuffix .tex, $(MACROS_FILES))

INTER = $(addprefix graphs/, $(GRAPHS_EPS))

.PHONY: all pdf fast clean cleanData cleanAll
.SECONDEXPANSION:
.INTERMEDIATE: $$(INTER)

all: thesis.pdf

pdf: thesis.pdf

fast: Fast = TRUE
fast: thesis.pdf

thesis.pdf: $(TEXS) citations.bib $(TEMPLATE) $$(addprefix images/, $(IMAGES)) $$(addprefix alg/, $(ALGS)) $$(addprefix graphs/, $(GRAPHS)) $$(addprefix drawings/, $(DRAWINGS_PDF)) $$(addprefix tables/, $(TABLES_TEXS)) $$(addprefix macros/, $(MACROS_TEXS))
	sed -i 's/\eqB/\begin{eqnarray}/g' !(thesis).tex
	sed -i 's/\eqE/\end{eqnarray}/g' !(thesis).tex
	pdflatex thesis.tex
	if [ "$(Fast)" = "FALSE" ]; then \
		makeglossaries thesis; \
		bibtex thesis; \
		pdflatex thesis.tex; \
		pdflatex thesis.tex; \
	fi

graphs/%.pdf: graphs/%.eps
	ps2pdf -dEPSCrop graphs/$*.eps graphs/$*.pdf
	-rm graphs/$*.eps

graphs/SDP_demo.tex graphs/SDP_demo.eps: sources/graphs/SDP_demo.gnuplot sources/graphs/SDP_demo-ac.dat sources/graphs/SDP_demo-pf.dat
	gnuplot sources/graphs/SDP_demo.gnuplot

graphs/SDP_performance.tex graphs/SDP_performance.eps: sources/graphs/SDP_performance.gnuplot data/SDP_performance.dat
	gnuplot sources/graphs/SDP_performance.gnuplot

graphs/%.tex graphs/%.eps: sources/graphs/%.gnuplot
	gnuplot sources/graphs/$*.gnuplot

tables/SDP_performance.tex macros/SDP_performance.tex data/SDP_performance.dat: data/SDP_matrices.mat data/SDP_timesPolyopt.mat data/SDP_timesSedumi.mat data/SDP_timesMosek.mat sources/scripts/SDP_timesLaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m SDP_timesLaTeX

clean:
	-rm thesis.!(tex)
	-rm $(addprefix graphs/, $(GRAPHS)) $(addprefix graphs/, $(GRAPHS_EPS))
	-rm tables/SDP_performance.tex
	-rm data/SDP_performance.dat 
	-rm macros/SDP_performance.tex 

cleanData:
	-rm data/SDP_matrices.mat data/SDP_timesPolyopt.mat data/SDP_timesSedumi.mat data/SDP_timesMosek.mat

cleanAll: clean cleanData

# Conditional data generation
data/SDP_timesPolyopt.mat: data/SDP_matrices.mat sources/scripts/SDP_polyopt.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_polyopt; \
	fi;

data/SDP_timesSedumi.mat: data/SDP_matrices.mat sources/scripts/SDP_sedumi.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; SDP_sedumi;exit;"; \
	fi;

data/SDP_timesMosek.mat: data/SDP_matrices.mat sources/scripts/SDP_mosek.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; SDP_mosek;exit;"; \
	fi;

data/SDP_matrices.mat: sources/scripts/SDP_generateData.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_generateData; \
	fi;
