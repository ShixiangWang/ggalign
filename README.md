
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggalign <a href="https://yunuuuu.github.io/ggalign/"><img src="man/figures/logo.png" align="right" height="139" alt="ggalign website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/Yunuuuu/ggalign/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Yunuuuu/ggalign/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/Yunuuuu/ggalign/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Yunuuuu/ggalign?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/ggalign)](https://CRAN.R-project.org/package=ggalign)
<!-- badges: end --> This package extends ggplot2, enabling consistent
axis alignment across multiple plots. It’s particularly useful for plots
where data order needs to be manipulated, such as aligning a dendrogram
with a heatmap.

## Installation

You can install `ggalign` from CRAN using `install.packages("ggalign")`.
Alternatively you can install the development version of `ggalign` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("Yunuuuu/ggalign")
```

## Overviews

`ggalign` pacakge provides two layout to arrange ggplot objects:

- `heatmap_layout()`/`ggheatmap()`: Arrange ggplot into a Heatmap
  layout. See `vignette("heatmap-layout")` for details.

- `stack_layout()`/`ggstack()`: Arrange ggplot vertically or
  horizontally. See `vignette("stack-layout")` for details.

To further customize these layouts, we offer following functions:

- `align_group()`: Group layout axis into panel with a group variable.
- `align_kmeans()`: Group layout axis into panel by kmeans
- `align_reorder()`: Reorders layout observations based on weights or
  summary statistics.
- `align_dendro()`: Reorder or Group layout based on hierarchical
  clustering

For more detailed instructions on customizing layouts, see the vignette:
`vignette("layout-customize")`.

Additionally, plots can be added in the layout with following functions:

- `align_gg()`/`ggalign()`: Create ggplot object with a customized data.
- `align_panel()`/`ggpanel()`: Create ggplot object with the layout
  panel data.

For more information on adding plots, refer to the vignette:
`vignette("layout-plot")`.

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

## Compare with ComplexHeatmap

### Pros

- Data can automatically inherit from the heatmap body, reducing the
  need for manual data manipulation.
- Heatmap annotation axes and legends are automatically generated,
  simplifying plot creation.
- Dendrograms can be easily customized and colored based on cluster
  characteristics, offering more flexibility in visual styling.
- Full integration with the ggplot2 ecosystem allows for a broader range
  of customization options, including advanced themes, layouts,
  annotation positioning, geoms, stats, and other ggplot2 components.
- Supports the full range of ggplot2 color palettes.
- Provides a more familiar workflow for users already accustomed to
  ggplot2, reducing the learning curve compared to a specialized package
  like ComplexHeatmap.
- Enhanced flexibility in controlling plot size, and spacing.
- Can easily align with ggplot2 plots by panel area.

### Cons

Fewer Built-In Annotations: May require additional coding for specific
annotations or customization compared to the extensive built-in
annotation function in ComplexHeatmap.

## Examples

![](https://yunuuuu.github.io/ggalign/articles/more-examples_files/figure-html/unnamed-chunk-3-1.png)
![](https://yunuuuu.github.io/ggalign/articles/more-examples_files/figure-html/unnamed-chunk-2-1.png)
