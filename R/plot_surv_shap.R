#' Plot SurvSHAP(t) Explanations for Survival Models
#'
#' This functions plots objects of class `surv_shap` - SurvSHAP time-dependent explanations of survival models.
#'
#' @param x an object of class `"surv_shap"` to be plotted
#' @param ... additional objects of class `surv_shap` to be plotted together
#' @param title character, title of the plot
#' @param subtitle character, subtitle of the plot, if `NULL` automatically generated as "created for XXX, YYY models", where XXX and YYY are explainer labels
#' @param colors character vector containing the colors to be used for plotting variables (containing either hex codes "#FF69B4", or names "blue")
#'
#' @return An object of the class `ggplot`.
#'
#' @family functions for plotting 'predict_parts_survival' objects
#'
#' @examples
#' \donttest{
#' library(survival)
#' library(survex)
#'
#' model <- randomForestSRC::rfsrc(Surv(time, status) ~ ., data = veteran)
#' exp <- explain(model)
#'
#' p_parts_shap <- predict_parts(exp, veteran[1, -c(3, 4)], type = "survshap")
#' plot(p_parts_shap)
#' }
#' @importFrom DALEX theme_drwhy
#' @export
plot.surv_shap <- function(x, ..., title = "SurvSHAP(t)", subtitle = NULL, colors = NULL) {

    dfl <- c(list(x), list(...))

    long_df <- lapply(dfl, function(x) {
        label <- attr(x, "label")
        sv <- x$result
        times <- x$eval_times
        transposed <- as.data.frame(cbind(times = times, sv))
        rownames(transposed) <- NULL
        long_df <- cbind(
            times = transposed$times,
            stack(transposed, select = -times),
            label = label
        )
    })

    long_df <- do.call(rbind, long_df)
    label <- unique(long_df$label)

    if (is.null(subtitle))
        subtitle <- paste0("created for the ", paste(label, collapse = ", "), " model")

    n_colors <- length(unique(long_df$ind))

    y_lab <- "SurvSHAP(t) value"

    ggplot(data = long_df, aes_string(x = "times", y = "values", color = "ind")) +
        geom_line(size = 0.8) +
        ylab(y_lab) + xlab("") +
        labs(title = title, subtitle = subtitle) +
        scale_color_manual("variable", values = generate_discrete_color_scale(n_colors, colors)) +
        theme_drwhy() +
        facet_wrap(~label, ncol = 1, scales = "free_y")

}
