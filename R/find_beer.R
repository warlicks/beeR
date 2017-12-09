#' Find a beer in BreweryDB
#'
#' @param api_key a charater string containing a BreweryDB API key.
#' See \url{http://www.brewerydb.com/developers} to obtain an API key.
#' @param name a character string containing the name of a beer.
#' @param ids a character string or vector of character strings containing
#' beer ids.
#' @param style_id
#' @param organic
#' @param status a character string indicating the status of an entity in BreweryDb.  Defaults to \emph{verified}.  Other possible status are
#' \emph{new_new_unverified}, \emph{update_pending}, \emph{delete_pending} and \emph{deleted}.
#' @param data_frame a logical argument indicating if the function should return
#' a data frame.  Defaults to \code{TRUE}.
#'
#' @return By default the function returns a data frame.  If
#' \code{data_frame = FALSE} the function returns a list of responses - 1 for each page of results - created by
#' \code{\link[httr]{GET}}
#' @export
#'
#' @examples
#'

# Define the function
find_beer <- function(api_key,
                      name = NULL,
                      ids = NULL,
                      style_id = NULL,
                      organic = NULL,
                      status = 'verified',
                      data_frame = TRUE) {

    # Set up base URL for the brewery get request
    base_url <- 'http://api.brewerydb.com/v2/beers'

    # Set Up Query params

    ## Create a comma sepearted string of ids.
    if (!is.null(ids)) {
        id_string <- paste(ids, collapse = ',')
    } else {
        id_string <- NULL
    }

    ## Create a list of all params.
    query_params <- list(key = api_key,
                         name = name,
                         ids = id_string,
                         styleId = style_id,
                         isOrganic = organic,
                         status = status,
                         format = 'json')

    # Set up the full url
    query_url <- httr::modify_url(base_url, query = query_params)

    # Call the API and check the response
    api_call <- httr::GET(query_url)
    httr::stop_for_status(api_call)

    # Check the number of pages in the result
    total_pages <- httr::content(api_call)$numberOfPages

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
