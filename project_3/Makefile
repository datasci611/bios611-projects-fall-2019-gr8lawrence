.PHONY: project3

	project3:
		docker build -t project3 .
		python ./scripts/data_wrangling.py
		Rscript ./scripts/project_3_init.R && mv project_3_markdown.html ../outputs/project_3_markdown.html
