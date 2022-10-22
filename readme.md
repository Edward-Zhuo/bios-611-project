Introduction to the dataset and intended analysis
=================================================

https://www.kaggle.com/datasets/fedesoriano/stroke-prediction-dataset

Stroke, one type of cardiovascular diseases, is a leading cause of long-term disability and death globally. It can be difficult to detect and requires immediate medical attention. Our understanding of cardiovascular diseases is still relatively primitive, and only a relatively limited amount of prevention and intervention methods are available. 

The conventional risk factors associated with strokes includes high blood pressure, high cholesterol, diabetes, coronary artery diseases and many other chronic diseases. The chosen dataset contains not only many of these risk factors, but also contains some novel attributes, like marriage status, work types (public, private, or self-employed) and residence types (urban and rural). It would be an interesting exploration to see if these unconventional attributes would have any contribution to predicting one’s likelihood of getting a stoke. 

An explorative data analysis will be performed first to see the structure of the dataset and the levels of the categorical variable, and clean the dataset if there is any unreasonable outlier observation. Also, data visualization would help us identify strong relationship between the covariates, if any. After performing an initial visualization and data analysis, then it might be possible to find an appropriate statistical model (or maybe machine learning model) to fit the dataset and conduct further analysis. In the likely case that a linear regression model is used, model diagnostics can be used to check if the model assumptions are satisfied, and variable selections can used to pick out the most important covariates in predicting whether a patient is likely to getting a stroke. We can then see if our interesting attributes truly have an influence or not. Finally, we can calculate the coefficient for the linear model and use statistical knowledge to compute confidence intervals for the coefficient. 

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

Users using a unix-flavor should
be able to start an RStudio server by running:

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
depends on) by simply issueing the command to make it.

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

The report/result of this analysis can be produced by invoking the following:

```
make writeup.pdf
```

And this will build the report and any missing dependencies required
on the way.

Results
=======
