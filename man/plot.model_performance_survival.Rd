% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_model_performance_survival.R
\name{plot.model_performance_survival}
\alias{plot.model_performance_survival}
\title{Plot Model Performance for Survival Models}
\usage{
\method{plot}{model_performance_survival}(x, ...)
}
\arguments{
\item{x}{an object of class \code{"model_performance_survival"} to be plotted}

\item{...}{additional parameters passed to the \code{plot.surv_model_performance} or \code{plot.surv_model_performance_rocs} function}
}
\value{
An object of the class \code{ggplot}.
}
\description{
This function is a wrapper for plotting \code{model_performance} objects created for survival models.
}
\section{Plot options}{

\subsection{\code{plot.surv_model_performance}}{
\itemize{
\item \code{x} - an object of class \code{"surv_model_performance"} to be plotted
\item \code{...} - additional objects of class \code{"surv_model_performance"} to be plotted together
\item \code{metrics} - character, names of metrics to be plotted (subset of C/D AUC", "Brier score" for \code{metrics_type \%in\% c("time_dependent", "functional")} or subset of "C-index","Integrated Brier score", "Integrated C/D AUC" for \code{metrics_type == "scalar"}), by default (\code{NULL}) all metrics of a given type are plotted
\item \code{metrics_type} - character, either one of \code{c("time_dependent","functional")} for functional metrics or \code{"scalar"} for scalar metrics
\item \code{title} - character, title of the plot
\item \code{subtitle} - character, subtitle of the plot, if \code{NULL} automaticaly generated as "created for XXX, YYY models", where XXX and YYY are explainer labels
\item \code{facet_ncol} - number of columns for arranging subplots
\item \code{colors} - character vector containing the colors to be used for plotting variables (containing either hex codes "#FF69B4", or names "blue")
}
}

\subsection{\code{plot.surv_model_performance_rocs}}{
\itemize{
\item \code{x} - an object of class \code{"surv_model_performance_rocs"} to be plotted
\item \code{...} - additional objects of class \code{"surv_model_performance_rocs"} to be plotted together
\item \code{title} - character, title of the plot
\item \code{subtitle} - character, subtitle of the plot, if \code{NULL} automaticaly generated as "created for XXX, YYY models", where XXX and YYY are explainer labels
\item \code{colors} - character vector containing the colors to be used for plotting variables (containing either hex codes "#FF69B4", or names "blue")
\item \code{facet_ncol} - number of columns for arranging subplots
}
}
}

\examples{
library(survival)
library(survex)

model <- randomForestSRC::rfsrc(Surv(time, status) ~ ., data = veteran)
exp <- explain(model)

m_perf <- model_performance(exp)
plot(m_perf, metrics_type = "functional")

m_perf_roc <- model_performance(exp, type = "roc", times = c(100, 300))
plot(m_perf_roc)

}
\seealso{
Other functions for plotting 'model_performance_survival' objects: 
\code{\link{plot.surv_model_performance_rocs}()},
\code{\link{plot.surv_model_performance}()}
}
\concept{functions for plotting 'model_performance_survival' objects}
