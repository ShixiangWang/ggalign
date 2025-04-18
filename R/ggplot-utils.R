#' @importFrom ggplot2 .pt
ggfun <- function(fn, mode = "any") from_namespace("ggplot2", fn, mode = mode)

allow_lambda <- function(x) {
    if (rlang::is_formula(x)) rlang::as_function(x) else x
}

#' @importFrom utils packageVersion
#' @importFrom rlang try_fetch
fill_alpha <- function(colour, alpha = NA) {
    if (packageVersion("ggplot2") >= "3.5.0") {
        ggplot2::fill_alpha(colour, alpha)
    } else {
        ggplot2::alpha(colour, alpha)
    }
}

is.waive <- function(x) inherits(x, "waiver")

`%|w|%` <- function(x, y) if (inherits(x, "waiver")) y else x

snake_class <- function(x) ggfun("snake_class")(x)

ggadd_default <- function(plot, mapping = NULL, theme = NULL) {
    if (!is.null(mapping)) {
        plot <- plot + mapping + .subset2(plot, "mapping")
    }
    if (!is.null(theme)) plot$theme <- theme + .subset2(plot, "theme")
    plot
}

is_palette_unset <- function(type, aes) {
    type <- match.arg(type, c("discrete", "continuous", "binned"))
    aes <- match.arg(aes, c("fill", "colour"))
    is.null(getOption(sprintf("ggplot2.%s.%s", type, aes)))
}

# A guide-box should be a `zeroGrob()` or a `gtable` object
#' @importFrom gtable is.gtable
maybe_guide_box <- function(x) inherits(x, "zeroGrob") || is.gtable(x)

######################################################
gguse_data <- function(plot, data) {
    # ggplot use waiver() to indicate no data
    plot["data"] <- list(data %||% waiver())
    plot
}

ggremove_margin <- function(plot, direction) {
    if (!is.null(direction) && packageVersion("ggplot2") > "3.5.2") {
        plot <- plot + switch_direction(
            direction,
            theme(plot.margin = margin(t = 0, r = NA, b = 0, l = NA)),
            theme(plot.margin = margin(t = NA, r = 0, b = NA, l = 0))
        )
    }
    plot
}

######################################################
default_expansion <- function(x = NULL, y = NULL) {
    structure(list(x = x, y = y), class = c("ggalign_default_expansion"))
}

#' @importFrom ggplot2 ggplot_add ggproto ggproto_parent
#' @export
ggplot_add.ggalign_default_expansion <- function(object, plot, object_name) {
    if (is.null(.subset2(object, "x")) && is.null(.subset2(object, "y"))) {
        return(plot)
    }
    ParentFacet <- .subset2(plot, "facet")
    plot$facet <- ggproto(
        NULL,
        ParentFacet,
        init_scales = function(self,
                               layout,
                               x_scale = NULL,
                               y_scale = NULL,
                               params) {
            if (!is.null(x_scale) && !is.null(.subset2(object, "x"))) {
                x_scale$expand <- x_scale$expand %|w|% .subset2(object, "x")
            }
            if (!is.null(y_scale) && !is.null(.subset2(object, "y"))) {
                y_scale$expand <- y_scale$expand %|w|% .subset2(object, "y")
            }
            ggproto_parent(ParentFacet, self)$init_scales(
                layout = layout,
                x_scale = x_scale,
                y_scale = y_scale,
                params = params
            )
        }
    )
    plot
}

######################################################
reverse_continuous_scale <- function(plot, axis) {
    if (plot$scales$has_scale(axis)) {
        # modify scale in place
        scale <- plot$scales$get_scales(axis)
        if (!scale$is_discrete()) {
            if (identical(scale$trans$name, "identity")) {
                scale$trans <- scales::as.transform("reverse")
            } else if (identical(scale$trans$name, "reverse")) {
                scale$trans <- scales::as.transform("identity")
            }
        }
    } else {
        plot <- plot +
            switch(axis,
                x = ggplot2::scale_x_reverse(),
                y = ggplot2::scale_y_reverse()
            )
    }
    plot
}

remove_scales <- function(plot, scale_aesthetics) {
    scales <- .subset2(plot, "scales")$clone()
    if (any(prev_aes <- scales$find(scale_aesthetics))) {
        scales$scales <- scales$scales[!prev_aes]
    }
    plot$scales <- scales
    plot
}

#' @importFrom rlang is_empty
extract_scales <- function(plot, axis, n_panel, facet_scales) {
    # if no facets, or if no facet scales, we replicate the single scale
    # object to match the panel numbers
    if (
        n_panel > 1L &&
            !is.null(facet_scales) &&
            !is_empty(ans <- .subset2(facet_scales, axis))
    ) {
    } else {
        ans <- rep_len(list(plot$scales$get_scales(axis)), n_panel)
    }
    ans
}
