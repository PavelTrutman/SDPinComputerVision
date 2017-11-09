SHELL:=/bin/bash -O extglob

# Set variable AllowGenerateData to "TRUE" if you want to allow to data regeneration
AllowGenerateData ?= FALSE

# fast compiling
Fast ?= FALSE

TEXS = thesis.tex abstract.tex acknowledgement.tex acronyms.tex CD.tex conclusion.tex declaration.tex introduction.tex SDP.tex POP.tex application.tex

TEMPLATE = cmpthesis.cls cmpcover.sty

IMAGES = CTU.pdf CIIRC.pdf LADIO_01.png LADIO_02.png

ALGS = self-concordant-function.tex analytic-center.tex path-follow.tex moment-matrix.tex

GRAPHS_FILES = SDP_hyperPar SDP_hyperParSlice SDP_demo SDP_barrier SDP_performance SDP_prec_eps_iters SDP_prec_perc_demo SDP_prec_perc_iters POP_multiplicationMatrices POP_Lasserre POP_dim_performance POP_deg_performance app_P3P_err app_P3P_cdist app_P3P_rangle app_P3P_times app_P3P_relax app_P35Pf_err app_P35Pf_cdist app_P35Pf_rangle app_P35Pf_times app_P35Pf_relax app_P35Pf_frel
GRAPHS_PDF = $(addsuffix .pdf, $(GRAPHS_FILES))
GRAPHS_TEX = $(addsuffix .tex, $(GRAPHS_FILES))
GRAPHS_EPS = $(addsuffix .eps, $(GRAPHS_FILES))
GRAPHS = $(GRAPHS_TEX) $(GRAPHS_PDF)

DRAWINGS_FILES = SDP_problem P3P
DRAWINGS_PDF = $(addsuffix .pdf, $(DRAWINGS_FILES))

TABLES_FILES = SDP_performance POP_dim_performance POP_deg_performance app_P3P_numberSolutions app_P35Pf_numberSolutions
TABLES_TEXS = $(addsuffix .tex, $(TABLES_FILES))

MACROS_FILES = SDP_performance SDP_prec_eps SDP_prec_perc POP_dim_performance POP_deg_performance app_LADIO app_P3P app_P35Pf
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
	sed -i 's/\eqB/\begin{align}/g' !(thesis).tex
	sed -i 's/\eqE/\end{align}/g' !(thesis).tex
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

graphs/SDP_prec_eps_iters.tex graphs/SDP_prec_eps_iters.eps: sources/graphs/SDP_prec_eps_iters.gnuplot data/SDP_prec_eps.dat
	gnuplot sources/graphs/SDP_prec_eps_iters.gnuplot

graphs/SDP_prec_perc_demo.tex graphs/SDP_prec_perc_demo.eps: sources/graphs/SDP_prec_perc_demo.gnuplot sources/graphs/SDP_prec_perc_demo.dat
	gnuplot sources/graphs/SDP_prec_perc_demo.gnuplot

graphs/SDP_prec_perc_iters.tex graphs/SDP_prec_perc_iters.eps: sources/graphs/SDP_prec_perc_iters.gnuplot data/SDP_prec_perc_iters.dat
	gnuplot sources/graphs/SDP_prec_perc_iters.gnuplot

graphs/POP_dim_performance.tex graphs/POP_dim_performance.eps: sources/graphs/POP_dim_performance.gnuplot data/POP_dim_performance.dat
	gnuplot sources/graphs/POP_dim_performance.gnuplot

graphs/POP_deg_performance.tex graphs/POP_deg_performance.eps: sources/graphs/POP_deg_performance.gnuplot data/POP_deg_performance.dat
	gnuplot sources/graphs/POP_deg_performance.gnuplot

graphs/app_P3P_err.tex graphs/app_P3P_err.eps: sources/graphs/app_P3P_err.gnuplot data/app_P3P_err.dat
	gnuplot sources/graphs/app_P3P_err.gnuplot

graphs/app_P3P_cdist.tex graphs/app_P3P_cdist.eps: sources/graphs/app_P3P_cdist.gnuplot data/app_P3P_cdist.dat
	gnuplot sources/graphs/app_P3P_cdist.gnuplot

graphs/app_P3P_rangle.tex graphs/app_P3P_rangle.eps: sources/graphs/app_P3P_rangle.gnuplot data/app_P3P_rangle.dat
	gnuplot sources/graphs/app_P3P_rangle.gnuplot

graphs/app_P3P_times.tex graphs/app_P3P_times.eps: sources/graphs/app_P3P_times.gnuplot data/app_P3P_times.dat
	gnuplot sources/graphs/app_P3P_times.gnuplot

graphs/app_P3P_relax.tex graphs/app_P3P_relax.eps: sources/graphs/app_P3P_relax.gnuplot data/app_P3P_relax.dat
	gnuplot sources/graphs/app_P3P_relax.gnuplot

graphs/app_P35Pf_err.tex graphs/app_P35Pf_err.eps: sources/graphs/app_P35Pf_err.gnuplot data/app_P35Pf_err.dat
	gnuplot sources/graphs/app_P35Pf_err.gnuplot

graphs/app_P35Pf_cdist.tex graphs/app_P35Pf_cdist.eps: sources/graphs/app_P35Pf_cdist.gnuplot data/app_P35Pf_cdist.dat
	gnuplot sources/graphs/app_P35Pf_cdist.gnuplot

graphs/app_P35Pf_rangle.tex graphs/app_P35Pf_rangle.eps: sources/graphs/app_P35Pf_rangle.gnuplot data/app_P35Pf_rangle.dat
	gnuplot sources/graphs/app_P35Pf_rangle.gnuplot

graphs/app_P35Pf_times.tex graphs/app_P35Pf_times.eps: sources/graphs/app_P35Pf_times.gnuplot data/app_P35Pf_times.dat
	gnuplot sources/graphs/app_P35Pf_times.gnuplot

graphs/app_P35Pf_relax.tex graphs/app_P35Pf_relax.eps: sources/graphs/app_P35Pf_relax.gnuplot data/app_P35Pf_relax.dat
	gnuplot sources/graphs/app_P35Pf_relax.gnuplot

graphs/app_P35Pf_frel.tex graphs/app_P35Pf_frel.eps: sources/graphs/app_P35Pf_frel.gnuplot data/app_P35Pf_frel.dat
	gnuplot sources/graphs/app_P35Pf_frel.gnuplot

graphs/%.tex graphs/%.eps: sources/graphs/%.gnuplot
	gnuplot sources/graphs/$*.gnuplot

tables/SDP_performance.tex macros/SDP_performance.tex data/SDP_performance.dat: data/SDP_matrices.mat data/SDP_timesPolyopt.mat data/SDP_timesSedumi.mat data/SDP_timesMosek.mat sources/scripts/SDP_timesLaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m SDP_timesLaTeX

macros/SDP_prec_eps.tex data/SDP_prec_eps.dat: data/SDP_prec_eps_matrices.mat data/SDP_prec_eps_results.mat sources/scripts/SDP_prec_eps_LaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m SDP_prec_eps_LaTeX

macros/SDP_prec_perc.tex data/SDP_prec_perc_iters.dat: data/SDP_prec_perc_matrices.mat data/SDP_prec_perc_results.mat sources/scripts/SDP_prec_perc_LaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m SDP_prec_perc_LaTeX

tables/POP_dim_performance.tex macros/POP_dim_performance.tex data/POP_dim_performance.dat: data/POP_dim_coefs.mat data/POP_dim_timesPolyopt.mat data/POP_dim_timesGloptipoly.mat sources/scripts/POP_dim_timesLaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m POP_dim_timesLaTeX

tables/POP_deg_performance.tex macros/POP_deg_performance.tex data/POP_deg_performance.dat: data/POP_deg_coefs.mat data/POP_deg_timesPolyopt.mat data/POP_deg_timesGloptipoly.mat sources/scripts/POP_deg_timesLaTeX.py
	PYTHONPATH=sources/scripts/ python3 -m POP_deg_timesLaTeX

macros/app_LADIO.tex: data/app_LADIO.mat sources/scripts/app_LADIO_macrosgenerator.py
	PYTHONPATH=sources/scripts/ python3 -m app_LADIO_macrosgenerator

macros/app_P3P.tex: sources/scripts/app_P3P.py
	PYTHONPATH=sources/scripts/ python3 -m app_P3P generatelatexmacros

macros/app_P35Pf.tex: sources/scripts/app_P35Pf.py
	PYTHONPATH=sources/scripts/ python3 -m app_P35Pf generatelatexmacros

data/app_P3P_err.dat data/app_P3P_cdist.dat data/app_P3P_rangle.dat data/app_P3P_times.dat data/app_P3P_relax.dat: data/app_P3P_results.mat sources/scripts/app_P3P.py
	PYTHONPATH=sources/scripts/ python3 -m app_P3P generategnuplot

data/app_P35Pf_err.dat data/app_P35Pf_cdist.dat data/app_P35Pf_rangle.dat data/app_P35Pf_times.dat data/app_P35Pf_relax.dat data/app_P35Pf_frel.dat: data/app_P35Pf_results.mat sources/scripts/app_P35Pf.py
	PYTHONPATH=sources/scripts/ python3 -m app_P35Pf generategnuplot

tables/app_P3P_numberSolutions.tex: data/app_P3P_cams.mat data/app_P3P_results.mat sources/scripts/app_P3P.py
	PYTHONPATH=sources/scripts/ python3 -m app_P3P generatetable

tables/app_P35Pf_numberSolutions.tex: data/app_P35Pf_cams.mat data/app_P35Pf_results.mat sources/scripts/app_P35Pf.py
	PYTHONPATH=sources/scripts/ python3 -m app_P35Pf generatetable

clean:
	-rm thesis.!(tex)
	-rm $(addprefix graphs/, $(GRAPHS)) $(addprefix graphs/, $(GRAPHS_EPS))
	-rm tables/SDP_performance.tex tables/POP_dim_performance.tex tables/POP_deg_performance.tex tables/app_P3P_numberSolutions.tex tables/app_P35Pf_numberSolutions.tex
	-rm data/SDP_performance.dat data/SDP_prec_eps.data data/SDP_prec_perc_iters.dat data/POP_dim_performance.dat data/POP_deg_performance.dat data/app_P3P_err.dat data/app_P3P_cdist.dat data/app_P3P_rangle.dat data/app_P3P_times.dat data/app_P3P_relax.dat data/app_P35Pf_err.dat data/app_P35Pf_cdist.dat data/app_P35Pf_rangle.dat data/app_P35Pf_times.dat data/app_P35Pf_relax.dat data/app_P35Pf_frel.dat
	-rm macros/SDP_performance.tex macros/SDP_prec_eps.tex macros/SDP_prec_perc.tex macros/POP_dim_performance.tex macros/POP_deg_performance.tex macros/app_LADIO.tex macros/app_P3P.tex macros/app_P35Pf.tex

cleanData:
	-rm data/SDP_matrices.mat data/SDP_timesPolyopt.mat data/SDP_timesSedumi.mat data/SDP_timesMosek.mat
	-rm data/SDP_prec_eps_matrices.mat data/SDP_prec_eps_results.mat
	-rm data/SDP_prec_perc_matrices.mat data/SDP_prec_perc_results.mat
	-rm data/POP_dim_coefs.mat data/POP_dim_timesPolyopt.mat data/POP_dim_timesGloptipoly.mat
	-rm data/POP_deg_coefs.mat data/POP_deg_timesPolyopt.mat data/POP_deg_timesGloptipoly.mat
	-rm data/app_P3P_cams.mat data/app_P3P_solAG.mat data/app_P3P_solPolyopt.mat data/app_P3P_solGloptipoly.mat data/app_P3P_solMosek.mat data/app_P3P_results.mat
	-rm data/app_P35Pf_cams.mat data/app_P35Pf_solAG.mat data/app_P35Pf_solPolyopt.mat data/app_P35Pf_solGloptipoly.mat data/app_P35Pf_solMosek.mat data/app_P35Pf_results.mat

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

data/SDP_prec_eps_results.mat: data/SDP_prec_eps_matrices.mat sources/scripts/SDP_prec_eps_polyopt.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_prec_eps_polyopt; \
	fi;

data/SDP_prec_eps_matrices.mat: sources/scripts/SDP_prec_eps_generateData.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_prec_eps_generateData; \
	fi;

data/SDP_prec_perc_results.mat: data/SDP_prec_perc_matrices.mat sources/scripts/SDP_prec_perc_polyopt.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_prec_perc_polyopt; \
	fi;

data/SDP_prec_perc_matrices.mat: sources/scripts/SDP_prec_perc_generateData.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m SDP_prec_perc_generateData; \
	fi;

data/POP_dim_timesPolyopt.mat: data/POP_dim_coefs.mat sources/scripts/POP_dim_polyopt.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m POP_dim_polyopt; \
	fi;

data/POP_dim_timesGloptipoly.mat: data/POP_dim_coefs.mat sources/scripts/POP_dim_gloptipoly.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; POP_dim_gloptipoly;exit;"; \
	fi;

data/POP_dim_coefs.mat: sources/scripts/POP_dim_generateData.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m POP_dim_generateData; \
	fi;

data/POP_deg_timesPolyopt.mat: data/POP_deg_coefs.mat sources/scripts/POP_deg_polyopt.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m POP_deg_polyopt; \
	fi;

data/POP_deg_timesGloptipoly.mat: data/POP_deg_coefs.mat sources/scripts/POP_deg_gloptipoly.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; POP_deg_gloptipoly;exit;"; \
	fi;

data/POP_deg_coefs.mat: sources/scripts/POP_deg_generateData.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m POP_deg_generateData; \
	fi;

data/app_P3P_cams.mat: data/app_LADIO.mat sources/scripts/app_P3P.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P3P preparedata; \
	fi;

data/app_P3P_solAG.mat: data/app_P3P_cams.mat sources/scripts/app_P3P.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P3P solveag; \
	fi;

data/app_P3P_solPolyopt.mat: data/app_P3P_cams.mat sources/scripts/app_P3P.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P3P solvepolyopt; \
	fi;

data/app_P3P_solGloptipoly.mat: data/app_P3P_cams.mat sources/scripts/app_P3P_solveGloptipoly.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; app_P3P_solveGloptipoly;exit;"; \
	fi;

data/app_P3P_solMosek.mat: data/app_P3P_cams.mat sources/scripts/app_P3P_solveMosek.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; app_P3P_solveMosek;exit;"; \
	fi;

data/app_P3P_results.mat: data/app_P3P_cams.mat data/app_LADIO.mat data/app_P3P_solAG.mat data/app_P3P_solPolyopt.mat data/app_P3P_solGloptipoly.mat data/app_P3P_solMosek.mat sources/scripts/app_P3P.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P3P processdata; \
	fi;

data/app_P35Pf_cams.mat: data/app_LADIO.mat sources/scripts/app_P35Pf.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P35Pf preparedata; \
	fi;

data/app_P35Pf_solAG.mat: data/app_P35Pf_cams.mat sources/scripts/app_P35Pf_solveAG.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; app_P35Pf_solveAG;exit;"; \
	fi;

data/app_P35Pf_solPolyopt.mat: data/app_P35Pf_cams.mat sources/scripts/app_P35Pf.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P35Pf solvepolyopt; \
	fi;

data/app_P35Pf_solGloptipoly.mat: data/app_P35Pf_cams.mat sources/scripts/app_P35Pf_solveGloptipoly.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; app_P35Pf_solveGloptipoly;exit;"; \
	fi;

data/app_P35Pf_solMosek.mat: data/app_P35Pf_cams.mat sources/scripts/app_P35Pf_solveMosek.m
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		matlab -nodesktop -nosplash -nojvm -r "addpath sources/scripts/; app_P35Pf_solveMosek;exit;"; \
	fi;

data/app_P35Pf_results.mat: data/app_P35Pf_cams.mat data/app_LADIO.mat data/app_P35Pf_solAG.mat data/app_P35Pf_solPolyopt.mat data/app_P35Pf_solGloptipoly.mat data/app_P35Pf_solMosek.mat sources/scripts/app_P35Pf.py
	if [ -e $@ ] && [ "$(AllowGenerateData)" != "TRUE" ]; then \
		touch $@; \
	else \
		PYTHONPATH=sources/scripts/ python3 -m app_P35Pf processdata; \
	fi;
