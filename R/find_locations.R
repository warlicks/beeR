#' Title
#'
#' @param api_key
#' @param locality
#' @param region
#' @param postal_code
#' @param status
#' @param data_frame
#'
#' @return
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
