
<!-- README.md is generated from README.Rmd. Please edit that file -->
beeR
====

[![Build Status](https://travis-ci.org/warlicks/beeR.svg?branch=master)](https://travis-ci.org/warlicks/beeR) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/beeR)](https://cran.r-project.org/package=beer) [![codecov](https://codecov.io/gh/warlicks/beeR/branch/master/graph/badge.svg)](https://codecov.io/gh/warlicks/beeR)

beeR is a package designed to interface with the [BreweryDB](http://www.brewerydb.com/developers/docs) API. BreweryDB is a crowd sourced database with data about breweries, beers, beer styles and ingredients.

At the moment it provides a wraper for GET requests to the style, catagories, beers, breweries and location endponts. In the near term we will work to provide get coverage to all of the API's endpoints. Eventually we would like to support the BreweryDB's post requests.

Installation
------------

beeR is under active development and not currently on CRAN. If you would like to experiment with the developmental build you can install from github.

``` r
#install.packages("devtools")
devtools::install_github('warlicks/beeR')  
```

Usage
-----

``` r
key <- # Replace with your API key

# Find Beer styles
all_styles <- find_styles(api_key = key, style_name = "") 

# Find Breweries in Seattle
seattle_breweries <- find_locations(api_key = key, locality = 'Seattle')

# Find Details for a brewery by name
dc_brau <- find_brewery(api_key = key, name = 'DC Brau Brewing Company')

# Find a specific beer
good_beer <- find_beer(api_key = key, name = 'Stoup Northwest Red')
```
