
SLIDES := $(patsubst %.Rmd,%.slides.pdf,$(wildcard Lecture-*.Rmd))
IOSLIDES := $(patsubst %.Rmd,%.ioslides.html,$(wildcard Lecture-*.Rmd))
SLIDY := $(patsubst %.Rmd,%.slidy.html,$(wildcard Lecture-*.Rmd))
REVEAL := $(patsubst %.Rmd,%.reveal.html,$(wildcard Lecture-*.Rmd))
HANDOUT := $(patsubst %.Rmd,%.handout.pdf,$(wildcard Lecture-*.Rmd))
TUFTE := $(patsubst %.Rmd,%.tufte.pdf,$(wildcard Lecture-*.Rmd))
PRACTICAL := $(patsubst %.Rmd,%.practical.pdf,$(wildcard Practical-*.Rmd))
TUTORIAL := $(patsubst %.Rmd,%.tutorial.pdf,$(wildcard Tutorial-*.Rmd))
ASSIGNMENT := $(patsubst %.Rmd,%.assignment.pdf,$(wildcard Assignment-*.Rmd))
MARKDOWN := $(patsubst %.Rmd,%.markdown.md,$(wildcard *.Rmd))

all: reveal slidy ioslides slides handouts practicals tutorials assignments tufte


slides : $(SLIDES)

reveal: $(REVEAL)

ioslides : $(IOSLIDES)

slidy : $(SLIDY)

handouts: $(HANDOUT)

tufte: $(TUFTE)

practicals: $(PRACTICAL)

tutorials: $(TUTORIAL)

assignments: $(ASSIGNMENT)

markdown: $(MARKDOWN)

%.slides.pdf : %.Rmd
	@echo "Processing Slides: $<"
	@if [[ $< -nt ./published/pdf/$(basename $<)-SLIDES.pdf ]]; then  Rscript -e "rmarkdown::render('$<','beamer_presentation', output_file ='./published/pdf/$(basename $<)-SLIDES.pdf')" ; else echo "File has not changed"; fi


%.ioslides.html : %.Rmd
	@echo "Processing ioslides: $< -> $@"
	@if [[ $< -nt ./published/ioslides/$(basename $<).html ]]; then Rscript -e "rmarkdown::render('$<','ioslides_presentation')"; mv $(basename $<).html ./published/ioslides/  ; else echo "File has not changed"; fi

%.reveal.html : %.Rmd
	@echo "Processing reveal: $< -> $@"
	@if [[ $< -nt ./published/reveal/$(basename $<).html ]]; then Rscript -e "rmarkdown::render('$<','revealjs::revealjs_presentation')"; mv $(basename $<).html ./published/reveal/  ; else echo "File has not changed"; fi


%.slidy.html : %.Rmd
	@echo "Processing slidy: $<"
	@if [[ $< -nt ./published/slidy/$(basename $<).html ]]; then Rscript -e "rmarkdown::render('$<','slidy_presentation')"; mv $(basename $<).html ./published/slidy/ ; else echo "File has not changed"; fi


%.handout.pdf : %.Rmd
	@echo "Processing handouts: $<"

		@if [[ $< -nt ./published/pdf/$(basename $<)-HANDOUT.pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='./published/pdf/$(basename $<)-HANDOUT.pdf')" ; else echo "File has not changed"; fi

%.tufte.pdf : %.Rmd
	@echo "Processing Tufte handouts: $<"

		@if [[ $< -nt ./published/pdf/$(basename $<)-TUFTE.pdf ]]; then  Rscript -e "rmarkdown::render('$<','rmarkdown::tufte_handout', output_file ='./published/pdf/$(basename $<)-TUFTE.pdf')" ; else echo "File has not changed"; fi


%.practical.pdf : %.Rmd
	@echo "Processing practicals: $<"
	@if [[ $< -nt ./published/pdf/$(basename $<).pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='./published/pdf/$(basename $<).pdf')" ; else echo "File  has not changed"; fi


%.tutorial.pdf : %.Rmd
	@echo "Processing tutorals: $<"
	@if [[ $< -nt ./published/pdf/$(basename $<).pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='./published/pdf/$(basename $<).pdf')" ; else echo "File  has not changed"; fi


%.assignment.pdf : %.Rmd
	@echo "Processing assignments: $<"
	@if [[ $< -nt ./published/pdf/$(basename $<).pdf ]]; then  Rscript -e "rmarkdown::render('$<','pdf_document', output_file ='./published/pdf/$(basename $<).pdf')" ; else echo "File  has not changed"; fi

%.markdown.md : %.Rmd
	@echo "Processing markdown: $<"
	@if [[ $< -nt ./published/epub/$(basename $<).mobi ]]; then  Rscript -e "rmarkdown::render('$<','md_document', output_file ='./published/md/$(basename $<).md')" ; pandoc --toc --epub-stylesheet=./includes/epub/stylesheet.css ./published/md/$(basename $<).md -o ./published/epub/$(basename $<).epub ; /Applications/calibre.app/Contents/MacOS/ebook-convert ./published/epub/$(basename $<).epub ./published/epub/$(basename $<).mobi ; else echo "File  has not changed"; fi


