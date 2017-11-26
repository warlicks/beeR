#' Find Beer Categories.
#'
#' @param api_key a charater string containing a BreweryDB API key.
#' See \url{http://www.brewerydb.com/developers} to obtain an API key.
#' @param id a character string providing the BreweryDB ID of a specific beer
#' category.
#' @param name a charater string providing the name of a specific beer category.
#' @param data_frame a logical argument indicating if the function should return
#' a data frame.  Defaults to \code{TRUE}
#'
#' @return By default the function returns a data frame.  If
#' \code{data_frame = FALSE} the function returns the response object created
#' by \code{\link[httr]{GET}}
#'
#' @export
#'
#' @examples
#'
find_categories <- function(api_key, id = NULL, name = NULL, data_frame = TRUE){

    # Set up base url for catagories endpoint.
    base_url <- 'http://api.brewerydb.com/v2/categories'

    # Set up query params and the url for the api call
    query_params <- list(key = api_key,
                         id = id,
                         name = name,
                         format = 'json')

    query_url <- httr::modify_url(base_url, query = query_params)

    # Call the api and check the response
    api_call <- httr::GET(query_url)
    httr::stop_for_status(api_call)

    # If the data frame argument is true we use the json_parse function to
    # return a data frame.  Other wise we return the raw API response.
    if (data_frame) {
        df <- json_parse(api_call)
        return(df)
    } else {
        return(api_call)
    }

}
