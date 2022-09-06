https://www.kaggle.com/datasets/fedesoriano/stroke-prediction-dataset

Stroke, one type of cardiovascular diseases, is a leading cause of long-term disability and death globally. It can be difficult to detect and requires immediate medical attention. Our understanding of cardiovascular diseases is still relatively primitive, and only a relatively limited amount of prevention and intervention methods are available. 

The conventional risk factors associated with strokes includes high blood pressure, high cholesterol, diabetes, coronary artery diseases and many other chronic diseases. The chosen dataset contains not only many of these risk factors, but also contains some novel attributes, like marriage status, work types (public, private, or self-employed) and residence types (urban and rural). It would be an interesting exploration to see if these unconventional attributes would have any contribution to predicting one’s likelihood of getting a stoke. 

An explorative data analysis will be performed first to see the structure of the dataset and the levels of the categorical variable, and clean the dataset if there is any unreasonable outlier observation. Also, data visualization would help us identify strong relationship between the covariates, if any. After performing an initial visualization and data analysis, then it might be possible to find an appropriate statistical model (or maybe machine learning model) to fit the dataset and conduct further analysis. In the likely case that a linear regression model is used, model diagnostics can be used to check if the model assumptions are satisfied, and variable selections can used to pick out the most important covariates in predicting whether a patient is likely to getting a stroke. We can then see if our interesting attributes truly have an influence or not. Finally, we can calculate the coefficient for the linear model and use statistical knowledge to compute confidence intervals for the coefficient. 

In summary, it would be an interesting exercise to explore the potential covariates that can predict the likelihood of getting strokes.

