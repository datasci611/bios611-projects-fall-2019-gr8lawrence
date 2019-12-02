.PHONY: project3

project3:
		docker image build -t project_3 .
		python ./scripts/data_wrangling.py
		Rscript ./scripts/project_3_init.R && mv ./scripts/project_3_markdown.html ./outputs/project_3_markdown.html
