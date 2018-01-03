#' Find ingridents used to make a beer.
#'
#' @param api_key a charater string containing a BreweryDB API key.
#' See \url{http://www.brewerydb.com/developers} to obtain an API key.
#' @param id a character string containing a beer id.
#' @param data_frame a logical argument indicating if the function should return
#' a data frame.  Defaults to \code{TRUE}.
#'
#' @return By default the function returns a data frame.  If
#' \code{data_frame = FALSE} the function returns a list of responses - 1
#' for each page of results - created by \code{\link[httr]{GET}}
#'
#' @export
#'
#' @examples
#' # Do Not Run
#' # find_beer_ingredients(key, id = 'WHQisc')

find_beer_ingredients <- function(api_key,
                             id,
                             data_frame = TRUE) {

    # Set up base URL for the brewery get request
    base_url <- 'http://api.brewerydb.com/v2/beer'

    ## Add the API Key to the URL.
    query_params <- list(key = api_key)

    # Set Up The URL
    query_url <- paste(base_url, id, 'ingredients', sep = '/')
    query_url <- httr::modify_url(query_url, query = query_params)

    # Call the API and check the response
    api_call <- httr::GET(query_url)
    httr::stop_for_status(api_call)

    # Check if there there is a data object in the response
    check_for_data_response(api_call)

    # Check the number of pages in the result
    total_pages <- httr::content(api_call)$numberOfPages

    if(is.null(total_pages)){
        total_pages <- 0
    }

    if(total_pages > 1){
        api_response <- get_multiple_pages(total_pages, api_call)
    }
    else{
        api_response <- list(page1 = api_call)
    }

    # If the data frame argument is true we use the json_parse function to
    # return a data frame.  Other wise we return the raw API response.
    if (data_frame) {
        df <- json_parse(api_response)
        return(df)
    } else {
        return(api_response)
    }
}
