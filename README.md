
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

- Full integration with the ggplot2 ecosystem.
- Heatmap annotation axes and legends are automatically generated.
- Data can automatically inherit from the heatmap body.
- Dendrograms can be easily customized and colored based on cluster
  characteristics.
- Enhanced flexibility in controlling plot size, and spacing.
- Can easily align with ggplot2 plots by panel area.

### Cons

Fewer Built-In Annotations: May require additional coding for specific
annotations or customization compared to the extensive built-in
annotation function in ComplexHeatmap.

## Examples

``` r
library(ggalign)
#> Loading required package: ggplot2
```

Let’s Prepare some example data.

``` r
set.seed(123)
small_mat <- matrix(rnorm(81), nrow = 9)
rownames(small_mat) <- paste0("row", seq_len(nrow(small_mat)))
colnames(small_mat) <- paste0("column", seq_len(ncol(small_mat)))
```

### Simple heatmap

``` r
ggheatmap(small_mat) + scale_fill_viridis_c()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### heatmap layout customize

#### Based on dendrogram

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("t") +
    align_dendro(aes(color = branch), k = 3) +
    geom_point(aes(color = branch, y = y)) +
    scale_color_brewer(palette = "Dark2")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

#### Based on kmeans

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("t") +
    align_kmeans(3L)
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

#### Based on a group variable

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("t") +
    align_group(sample(letters[1:4], ncol(small_mat), replace = TRUE))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

#### Based on a ordering weights

Here, we ordered the heatmap rows based on the row means.

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("l") +
    align_reorder(rowMeans)
```

<img src="man/figures/README-unnamed-chunk-7-1.png" width="100%" />

### Heatmap annotation plot

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("t") +
    align_dendro(aes(color = branch), k = 3) +
    geom_point(aes(color = branch, y = y)) +
    scale_color_brewer(palette = "Dark2") +
    ggalign(aes(y = value)) +
    geom_boxplot(aes(fill = .panel, group = interaction(.x, .panel))) +
    scale_fill_brewer(palette = "Dark2")
```

<img src="man/figures/README-unnamed-chunk-8-1.png" width="100%" />

``` r
ggheatmap(small_mat) +
    scale_fill_viridis_c() +
    hmanno("t", size = 0.5) +
    align_dendro(aes(color = branch), k = 3L) +
    ggalign(aes(y = value), data = rowSums) +
    geom_bar(stat = "identity", aes(fill = factor(.panel))) +
    scale_fill_brewer(name = NULL, palette = "Dark2") +
    hmanno("l", size = 0.5) +
    align_dendro(aes(color = branch), size = 0.5, k = 4L) +
    scale_x_reverse() +
    ggalign(aes(x = value), data = rowSums) +
    geom_bar(
        aes(y = .y, fill = factor(.y)),
        stat = "identity",
        orientation = "y"
    ) +
    scale_fill_brewer(name = NULL, palette = "Paired", guide = "none") +
    scale_x_reverse()
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="100%" />

### Multiple heatmaps

#### Horizontal layout

``` r
(ggstack(small_mat) +
    ggheatmap() +
    ggheatmap() &
    scale_fill_viridis_c() &
    theme(axis.text.x = element_text(angle = -60, hjust = 0))) +
    stack_active() +
    align_dendro(aes(color = branch), k = 4L, size = 0.2) +
    scale_color_brewer(palette = "Dark2")
```

<img src="man/figures/README-unnamed-chunk-10-1.png" width="100%" />

#### Vertical layout

``` r
ggstack(small_mat, "v") +
    align_dendro(aes(color = branch),
        k = 4L, size = 0.2,
        theme = theme(axis.text.x = element_blank())
    ) +
    scale_color_brewer(palette = "Dark2") +
    ggheatmap() +
    ggheatmap() &
    scale_fill_viridis_c() &
    theme(axis.text.x = element_text(angle = -60, hjust = 0))
```

<img src="man/figures/README-unnamed-chunk-11-1.png" width="100%" />

### More Complex example

![](https://yunuuuu.github.io/ggalign/articles/more-examples_files/figure-html/unnamed-chunk-2-1.png)

### Session information

``` r
sessionInfo()
#> R version 4.4.0 (2024-04-24)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04 LTS
#> 
#> Matrix products: default
#> BLAS/LAPACK: /usr/lib/x86_64-linux-gnu/libmkl_rt.so;  LAPACK version 3.8.0
#> 
#> locale:
#>  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
#>  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
#>  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
#> [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
#> 
#> time zone: Asia/Shanghai
#> tzcode source: system (glibc)
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] ggalign_0.0.4 ggplot2_3.5.1
#> 
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5        cli_3.6.3          knitr_1.47         rlang_1.1.4       
#>  [5] xfun_0.45          highr_0.11         purrr_1.0.2        generics_0.1.3    
#>  [9] labeling_0.4.3     glue_1.7.0         ggh4x_0.2.8        colorspace_2.1-0  
#> [13] htmltools_0.5.8.1  scales_1.3.0       fansi_1.0.6        rmarkdown_2.27    
#> [17] grid_4.4.0         evaluate_0.24.0    munsell_0.5.1      tibble_3.2.1      
#> [21] fastmap_1.2.0      yaml_2.3.8         lifecycle_1.0.4    compiler_4.4.0    
#> [25] dplyr_1.1.4        RColorBrewer_1.1-3 pkgconfig_2.0.3    tidyr_1.3.1       
#> [29] farver_2.1.2       digest_0.6.36      viridisLite_0.4.2  R6_2.5.1          
#> [33] tidyselect_1.2.1   utf8_1.2.4         pillar_1.9.0       magrittr_2.0.3    
#> [37] withr_3.0.0        tools_4.4.0        gtable_0.3.5
```
