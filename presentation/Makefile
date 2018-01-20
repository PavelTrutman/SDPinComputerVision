SHELL:=/bin/bash -O extglob

TEXS = presentation.tex

TEMPLATE = arpgcell.sty bigfig.sty bigfig.tex cmptalk.cls cmpvideo.sty fltfonts-vz.def

IMAGES = cmp.png

GRAPHS_FILES = pre_P3P_err pre_P3P_times pre_P3P_relax pre_large_P3P_err pre_large_P3P_times pre_large_P3P_relax pre_P35Pf_err pre_P35Pf_times pre_P35Pf_relax pre_large_P35Pf_err pre_large_P35Pf_times pre_large_P35Pf_relax pre_large_P35Pf_frel
GRAPHS_PDF = $(addsuffix .pdf, $(GRAPHS_FILES))
GRAPHS_TEX = $(addsuffix .tex, $(GRAPHS_FILES))
GRAPHS_EPS = $(addsuffix .eps, $(GRAPHS_FILES))
GRAPHS = $(GRAPHS_TEX) $(GRAPHS_PDF)

DRAWINGS_FILES = pre_momentMethod
DRAWINGS_PDF = $(addsuffix .pdf, $(DRAWINGS_FILES))

INTER = $(addprefix ../graphs/, $(GRAPHS_EPS))

.PHONY: all pdf clean
.SECONDEXPANSION:
.INTERMEDIATE: $$(INTER)

all: presentation.pdf

pdf: presentation.pdf

presentation.pdf: $(TEXS) ../citations.bib $(TEMPLATE) $$(addprefix ../images/, $(IMAGES)) $$(addprefix ../graphs/, $(GRAPHS)) $$(addprefix ../drawings/, $(DRAWINGS_PDF))
	pdflatex presentation
	bibtex presentation
	pdflatex presentation
	pdflatex presentation

../graphs/%.pdf: ../graphs/%.eps
	ps2pdf -dEPSCrop ../graphs/$*.eps ../graphs/$*.pdf
	-rm ../graphs/$*.eps

../graphs/pre_P3P_err.tex ../graphs/pre_P3P_err.eps: ../sources/graphs/pre_P3P_err.gnuplot ../data/app_P3P_err.dat
	cd ..; \
	gnuplot sources/graphs/pre_P3P_err.gnuplot

../graphs/pre_P3P_times.tex ../graphs/pre_P3P_times.eps: ../sources/graphs/pre_P3P_times.gnuplot ../data/app_P3P_times.dat
	cd ..; \
	gnuplot sources/graphs/pre_P3P_times.gnuplot

../graphs/pre_P3P_relax.tex ../graphs/pre_P3P_relax.eps: ../sources/graphs/pre_P3P_relax.gnuplot ../data/app_P3P_relax.dat
	cd ..; \
	gnuplot sources/graphs/pre_P3P_relax.gnuplot

../graphs/pre_large_P3P_err.tex ../graphs/pre_large_P3P_err.eps: ../sources/graphs/pre_large_P3P_err.gnuplot ../data/app_P3P_err.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P3P_err.gnuplot

../graphs/pre_large_P3P_times.tex ../graphs/pre_large_P3P_times.eps: ../sources/graphs/pre_large_P3P_times.gnuplot ../data/app_P3P_times.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P3P_times.gnuplot

../graphs/pre_large_P3P_relax.tex ../graphs/pre_large_P3P_relax.eps: ../sources/graphs/pre_large_P3P_relax.gnuplot ../data/app_P3P_relax.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P3P_relax.gnuplot

../graphs/pre_P35Pf_err.tex ../graphs/pre_P35Pf_err.eps: ../sources/graphs/pre_P35Pf_err.gnuplot ../data/app_P35Pf_err.dat
	cd ..; \
	gnuplot sources/graphs/pre_P35Pf_err.gnuplot

../graphs/pre_P35Pf_times.tex ../graphs/pre_P35Pf_times.eps: ../sources/graphs/pre_P35Pf_times.gnuplot ../data/app_P35Pf_times.dat
	cd ..; \
	gnuplot sources/graphs/pre_P35Pf_times.gnuplot

../graphs/pre_P35Pf_relax.tex ../graphs/pre_P35Pf_relax.eps: ../sources/graphs/pre_P35Pf_relax.gnuplot ../data/app_P35Pf_relax.dat
	cd ..; \
	gnuplot sources/graphs/pre_P35Pf_relax.gnuplot

../graphs/%.tex graphs/%.eps: ../sources/graphs/%.gnuplot
	cd ..; \
	gnuplot sources/graphs/$*.gnuplot

../graphs/pre_large_P35Pf_err.tex ../graphs/pre_large_P35Pf_err.eps: ../sources/graphs/pre_large_P35Pf_err.gnuplot ../data/app_P35Pf_err.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P35Pf_err.gnuplot

../graphs/pre_large_P35Pf_times.tex ../graphs/pre_large_P35Pf_times.eps: ../sources/graphs/pre_large_P35Pf_times.gnuplot ../data/app_P35Pf_times.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P35Pf_times.gnuplot

../graphs/pre_large_P35Pf_relax.tex ../graphs/pre_large_P35Pf_relax.eps: ../sources/graphs/pre_large_P35Pf_relax.gnuplot ../data/app_P35Pf_relax.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P35Pf_relax.gnuplot

../graphs/pre_large_P35Pf_frel.tex ../graphs/pre_large_P35Pf_frel.eps: ../sources/graphs/pre_large_P35Pf_frel.gnuplot ../data/app_P35Pf_frel.dat
	cd ..; \
	gnuplot sources/graphs/pre_large_P35Pf_frel.gnuplot

../graphs/%.tex graphs/%.eps: ../sources/graphs/%.gnuplot
	cd ..; \
	gnuplot sources/graphs/$*.gnuplot

clean:
	-rm presentation.!(tex)
	-rm $(addprefix ../graphs/, $(GRAPHS)) $(addprefix ../graphs/, $(GRAPHS_EPS))
