Introduction to the dataset and intended analysis
=================================================

https://www.kaggle.com/datasets/fedesoriano/stroke-prediction-dataset

Stroke, one type of cardiovascular diseases, is a leading cause of long-term disability and death globally. It can be difficult to detect and requires immediate medical attention. Our understanding of cardiovascular diseases is still relatively primitive, and only a relatively limited amount of prevention and intervention methods are available.

The conventional risk factors associated with strokes includes high blood pressure, high cholesterol, diabetes, coronary artery diseases and many other chronic diseases. The chosen dataset contains not only many of these risk factors, but also contains some novel attributes, like marriage status, work types (public, private, or self-employed) and residence types (urban and rural). It is interesting to explore if these unconventional attributes would have any contribution to predicting one’s likelihood of getting a stoke.

A data cleaning step and explorative data analysis (EDA) will be performed first to see the structure of the dataset, the levels of the discrete (categorical) variables, and the distribution of the continuous variables. Also, data visualization could help to identify strong relationship between the covariates, if any. After performing an initial explorative data analysis and visualization, the dataset is analyzed with Linear Discriminant Analysis, Logistic regression, and AdaBoost. The fit is then compared and discussed.  We can then see if the interesting novel attributes truly have an influence or not.

In summary, it would be an interesting exercise to explore the potential covariates that can predict the likelihood of getting strokes.

Using This Repository
=====================

This repository is best used via Docker although you may be able to
consult the Dockerfile to understand what requirements are appropriate
to run the code.

Docker is a tool from software engineering (really, deployment) which
is nevertheless of great use to the data scientist. Docker builds an
_environment_ (think of it as a light weight virtual computer) which
contains all the software needed for the project. This allows any user
with Docker (or a compatible system) to run the code without bothering
with the often complex task of installing all the required libraries.

Build the docker image by typing in the terminal:
```
docker build . -t 611
```

Then start an RStudio server by running:

```
docker run -v $(pwd):/home/rstudio/work\
           -p 8787:8787\
           -e PASSWORD="611"\
           -it 611
```

You then visit http://localhost:8787 via a browser on your machine with username
rstudio and password 611 to access the machine and development environment.

Project Organization
====================

The best way to understand what this project does is to examine the
Makefile.

A Makefile is a textual description of the relationships between
_artifacts_ (like data, figures, source files, etc). In particular, it
documents for each artifact of interest in the project:

1. what is needed to construct that artifact
2. how to construct it

But a Makefile is more than documentation. Using the _tool_ make
(included in the Docker container), the Makefile allows for the
automatic reproduction of an artifact (and all the artifacts which it
depends on) by simply issuing the command to make it.

Consider this snippet from the Makefile included in this project:

```
#clean the dataset
clean_data.csv: .created-dirs data_explore_clean.R \
	source_data/healthcare-dataset-stroke-data.csv
	Rscript data_explore_clean.R
```

The lines with `#` are comments which just describe the target. Here
we describe an artifact (`clean_data.csv`), its
dependencies (`.created-dirs`, `data_explore_clean.R`,
`source_data/healthcare-dataset-stroke-data.csv`) and how to build it `Rscript
data_explore_clean.R`. If we invoke Make like so:

```
make clean_data.csv
```

Make will construct this artifact for us. If any dependency
doesn't exist for some reason it
will _also_ construct that artifact on the way. This greatly
simplifies the reproducibility of builds and also documents
dependencies.

What to Look At
===============

The report/result of this analysis can be produced by invoking the following
through the terminal in RStudio:

```
cd work
make report.pdf
```

And this will build the report and any missing dependencies required
on the way.

Results
=======
For our dataset, two of the novel attributes seem to have a significant correlation with the dichotomous stroke outcome during the explorative data analysis stage. The variable selection procedure in logistic regression most often picks some of the conventional variables as important predictors: smoking status(seed 319) heart_disease(seed 295), hypertension, avg_glucose_level, and age, with the last three always being selected. However, for some seeds (seed 359), work type and residence type are also being selected， which indicates those two novel attributes may indeed have some importance in the stroke outcome. This is an interesting result and worth further looking into with larger and more balanced dataset. (The dataset is heavily unbalanced, with only 5% having stroke outcome.) Also, it is worth noting that for analysis of this dataset, the three methods (LDA, Logistic regression, and Adaboost) have similar power in prediction.
