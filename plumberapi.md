RestFul API in R using plumber
================
francis kyalo
2023-01-28

## Model

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.1.3

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.4.0     v purrr   0.3.4
    ## v tibble  3.1.5     v dplyr   1.0.7
    ## v tidyr   1.1.4     v stringr 1.4.0
    ## v readr   2.1.2     v forcats 0.5.1

    ## Warning: package 'ggplot2' was built under R version 4.1.3

    ## Warning: package 'readr' was built under R version 4.1.3

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

The aim is to build a model that predicts hwy using some predictors

``` r
mpg %>% head()
```

    ## # A tibble: 6 x 11
    ##   manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class 
    ##   <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
    ## 1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compa~
    ## 2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compa~
    ## 3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compa~
    ## 4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compa~
    ## 5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compa~
    ## 6 audi         a4      2.8  1999     6 manual(m5) f        18    26 p     compa~

Checking for correlations to see how they are correlated with the
response

``` r
mpg %>% select(displ, cty, hwy) %>% cor()
```

    ##           displ        cty        hwy
    ## displ  1.000000 -0.7985240 -0.7660200
    ## cty   -0.798524  1.0000000  0.9559159
    ## hwy   -0.766020  0.9559159  1.0000000

`displ` and `cty` seem to be good candidates for the model that predicts
`hwy`

``` r
df <- mpg %>% select(displ, cty, hwy)
model <- lm(hwy ~ cty + displ, data =df)
model %>% summary()
```

    ## 
    ## Call:
    ## lm(formula = hwy ~ cty + displ, data = df)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -5.3124 -1.2423  0.0053  1.0296  4.1243 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  1.15145    1.21271   0.949    0.343    
    ## cty          1.32914    0.04490  29.602   <2e-16 ***
    ## displ       -0.03432    0.14791  -0.232    0.817    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.756 on 231 degrees of freedom
    ## Multiple R-squared:  0.9138, Adjusted R-squared:  0.913 
    ## F-statistic:  1224 on 2 and 231 DF,  p-value: < 2.2e-16

Save the model as an RDS object for use

``` r
write_rds(model, "model-mpg.rds")
```
