
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggalign <a href="https://yunuuuu.github.io/ggalign/"><img src="man/figures/logo.png" align="right" height="139" alt="ggalign website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/Yunuuuu/ggalign/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Yunuuuu/ggalign/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Yunuuuu/ggalign/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Yunuuuu/ggalign?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/ggalign)](https://CRAN.R-project.org/package=ggalign)
<!-- badges: end --> This package extends ggplot2 by providing advanced
tools for aligning and organizing multiple plots, particularly those
that automatically reorder observations, such as dendrograms. It offers
flexible control over plot layout and plot annotations, enabling users
to create complex, publication-quality heatmaps or combined
visualizations while utilizing the familiar grammar of graphics.

## Installation

You can install `ggalign` from CRAN using `install.packages("ggalign")`.
Alternatively you can install the development version of `ggalign` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("Yunuuuu/ggalign")
```

## Basic example

The usage of `ggalign` is simple if you known ggplot2 syntax, we first
initialize the layout, we then reorder the layout, or group the layout
into panels, and add plots, layers, scales, coords with `+`.

``` r
library(ggalign)
set.seed(123)
small_mat <- matrix(rnorm(81), nrow = 9)
rownames(small_mat) <- paste0("row", seq_len(nrow(small_mat)))
colnames(small_mat) <- paste0("column", seq_len(ncol(small_mat)))

# initialize the heamtap layout, we can regard it as a normal ggplot object
ggheatmap(small_mat) + 
    # we can directly modify geoms, scales and other ggplot2 components
    scale_fill_viridis_c() +
    # add annotation in the top
    hmanno("top") +
    # in the top annotation, we add a dendrogram, and split observations into 3 groups
    align_dendro(aes(color = branch), k = 3) +
    # in the dendrogram we add a point geom
    geom_point(aes(color = branch, y = y)) +
    # change color mapping for the dendrogram
    scale_color_brewer(palette = "Dark2")
```

![](https://yunuuuu.github.io/ggalign/articles/complete-examples_files/figure-html/unnamed-chunk-3-1.png)

## More Complex Examples

![](https://yunuuuu.github.io/ggalign/articles/more-examples_files/figure-html/unnamed-chunk-3-1.png)
![](https://yunuuuu.github.io/ggalign/articles/more-examples_files/figure-html/unnamed-chunk-2-1.png)

## Documentation

- [Heatmap
  Layout](https://yunuuuu.github.io/ggalign/articles/heatmap-layout.html)
- [Layout
  Customization](https://yunuuuu.github.io/ggalign/articles/layout-customize.html)
- [Layout
  Plot](https://yunuuuu.github.io/ggalign/articles/layout-plot.html)
- [Stack
  Layout](https://yunuuuu.github.io/ggalign/articles/stack-layout.html)
- [Scales and
  Facets](https://yunuuuu.github.io/ggalign/articles/scales-and-facets.html)

## Compre with other ggplot2 heatmap extension

In comparison to other heatmap extensions of ggplot2, such as
[ggheatmap](https://github.com/XiaoLuo-boy/ggheatmap), `ggalign` fully
supports the ggplot2 syntax. This means you can incorporate any geoms,
stats, scales, etc., and allowing for the creation of more complex
heatmap layouts, including multiple heatmaps arranged vertically or
horizontally.

## Compare with ComplexHeatmap

### Pros

- Full integration with the ggplot2 ecosystem.
- Heatmap annotation axes and legends are automatically generated.
- Dendrograms can be easily customized and colored based on cluster
  characteristics.
- Enhanced flexibility in controlling plot size, and spacing.
- Can easily align with ggplot2 plots by panel area.

### Cons

Fewer Built-In Annotations: May require additional coding for specific
annotations or customization compared to the extensive built-in
annotation function in ComplexHeatmap.
