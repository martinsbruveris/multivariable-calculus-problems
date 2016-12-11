# Needed to set shopt
SHELL := /bin/bash

# Set 0 for debug, 1 for final version
asy_highres := 0

# Directory for asymptote files
work_dir_asy := tmp_asy

# Needed to call gnuplot
latex_options := -shell-escape

solution_files = $(patsubst %.tex, %.pdf, $(wildcard solutions_*.tex))
problem_files = $(patsubst %.tex, %.pdf, $(wildcard problems_*.tex))

%.pdf : %.tex
	@echo 'Compiling $@'

# Create directory for asymptote files
	mkdir -p $(work_dir_asy)

# Set asymptote resolution
ifeq ($(asy_highres), 1)
		@echo "\\asyhighrestrue" > asy_flags.tex
else
		@echo "\\asyhighresfalse" > asy_flags.tex
endif

# First compile
	pdflatex $(latex_options) $<

# Create asymptote graphics
	cd $(work_dir_asy) && \
	shopt -s nullglob && \
	for f in $(basename $<)-*.asy; \
	do \
		echo "$$f"; \
		asy "$$f" -v; \
	done

# Run biber
	biber $(basename $<)

# Second and third compile
	pdflatex $(latex_options) $<
	pdflatex $(latex_options) $<

# Reset contents of asy_flags.tex
	@echo "" > asy_flags.tex

	@echo 'Finished compiling $@'

solutions: $(solution_files)

problems: $(problem_files)

all: solutions problems

clean:
# Remove LaTeX files
	rm -f *.aux *.bbl *.bcf *.blg *.log *.out \
				*.pgf-plot.gnuplot *.pgf-plot.table \
				*.pre *.run.xml *.toc

# Remove asymptote files
	rm -f $(work_dir_asy)/*.asy \
				$(work_dir_asy)/*.aux \
				$(work_dir_asy)/*.log \
				$(work_dir_asy)/*.pre \
				$(work_dir_asy)/*.tex \
				$(work_dir_asy)/*.out \
				$(work_dir_asy)/*.pbsdat \
				$(work_dir_asy)/*.pdf
	rm -fd $(work_dir_asy)
