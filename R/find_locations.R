#' Find Breweries By Location
#'
#' @param api_key a charater string containing a BreweryDB API key.
#' See \url{http://www.brewerydb.com/developers} to obtain an API key.
#' @param locality a character string indicating the location of the breweries.
#' In the US this corespods to a city.
#' @param region a character string indicating the location of the breweries.
#' In the US this corespods to a state
#' @param postal_code a character string providing the postal code of a location.
#' @param status a character string indicating the status of an entity in
#' BreweryDb.  Defaults to \emph{verified}.  Other possible status are
#' \emph{new_new_unverified}, \emph{update_pending}, \emph{delete_pending}
#' and \emph{deleted}
#' @param data_frame a logical argument indicating if the function should return
#' a data frame.  Defaults to \code{TRUE}.
#'
#' @return By default the function returns a data frame.  If
#' \code{data_frame = FALSE} the function returns the response object created
#' by \code{\link[httr]{GET}}
#' @export
#'
#' @examples
find_locations <- function(api_key,
                           locality = NULL,
                           region = NULL,
                           postal_code = NULL,
                           status = 'verified',
                           data_frame = TRUE) {

    # Set up base URL for the brewery get request
    base_url <- 'http://api.brewerydb.com/v2/locations'

    # Set Up query params and url for the query
    query_params <- list(key = api_key,
                         locality = locality,
                         region = region,
                         postalCode = postal_code,
                         status = status,
                         format = 'json')

    query_url <- httr::modify_url(base_url, query = query_params)


    #Call the api and check the status
    # Call the API and check the response
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
