.PHONY: clean


clean:
	rm -rf figures
	rm -rf .created-dirs
	rm -f clean_data.csv
	rm -f data_explore.txt
	rm -f  writeup.pdf

.created-dirs:
	mkdir -p figures
	touch .created-dirs

#clean the dataset
clean_data.csv: .created-dirs data_explore_clean.R \
	source_data/healthcare-dataset-stroke-data.csv
	Rscript data_explore_clean.R

#basic facts of the dataset
data_explore.txt: data_explore_clean.R \
	source_data/healthcare-dataset-stroke-data.csv
	Rscript data_explore_clean.R

#generated figures for final report to use
figures/stroke_variables.png: .created-dirs data_analysis.R clean_data.csv
	Rscript data_analysis.R

figures/c_variable_distributions.png: .created-dirs data_analysis.R clean_data.csv
	Rscript data_analysis.R

figures/d_variable_distributions.png: .created-dirs data_analysis.R clean_data.csv
	Rscript data_analysis.R

figures/roc.png: .created-dirs data_analysis.R clean_data.csv
		Rscript data_analysis.R

# Build the final report for the project
report.pdf: figures/variables.png figures/lm_age.png
		R -e "rmarkdown::render(\"writeup.Rmd\", output_format=\"pdf_document\")"
