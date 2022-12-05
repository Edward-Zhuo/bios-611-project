FROM rocker/verse
RUN Rscript --no-restore --no-save -e "install.packages('readxl')"
RUN Rscript --no-restore --no-save -e "install.packages('ggpubr')"
RUN Rscript --no-restore --no-save -e "install.packages('pROC')"
RUN Rscript --no-restore --no-save -e "install.packages('caret')"
RUN Rscript --no-restore --no-save -e "install.packages('adabag')"
RUN Rscript --no-restore --no-save -e "install.packages('PerformanceAnalytics')"


RUN Rscript --no-restore --no-save -e "remotes::install_github('eddelbuettel/rcppcorels')"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"wrapfig\",\"ec\",\"ulem\",\"amsmath\",\"capt-of\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"hyperref\",\"iftex\",\"pdftexcmds\",\"infwarerr\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"kvoptions\",\"epstopdf\",\"epstopdf-pkg\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"hanging\",\"grfext\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"etoolbox\",\"xcolor\",\"geometry\"))"

RUN Rscript --no-restore --no-save -e "update.packages(ask = FALSE);"
