#' Title
#'
#' @param api_key
#' @param name
#' @param ids
#' @param established
#' @param status
#' @param data_frame
#'
#' @return
#' @export
#'
#' @examples
find_brewery <- function(api_key,
                         name = NULL,
                         ids = NULL,
                         established = NULL,
                         status = 'verified',
                         data_frame = TRUE) {

    # Set up base URL for the brewery get request
    base_url <- 'http://api.brewerydb.com/v2/breweries'

    # Set Up Query params
    query_params <- list(key = api_key,
                         name = name,
                         ids = ids,
                         established = established,
                         status = status,
                         format = 'json')

    # Set up the full url
    query_url <- httr::modify_url(base_url, query = query_params)

    # Call the API and check the response
    api_call <- httr::GET(query_url)
    httr::stop_for_status(api_call)

    if (data_frame) {
        df <- json_parse(api_call)
        return(df)
    } else {
        return(api_call)
    }
}
