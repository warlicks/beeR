#' Find Beer Styles.
#'
#' @param api_key a charater string containing a BreweryDB API key.
#' See \url{http://www.brewerydb.com/developers} to obtain an API key.
#' @param style_id a character string providing the BreweryDB ID of a specific
#' beer style.
#' @param style_name a character string providing the name of specific beer
#' style.
#' @param category_id a character string providing the BreweryDB ID of a
#' specific beer category.
#' @param category_name a charater string providing the name of a specific beer
#'  category.
#' @param data_frame a logical argument indicating if the function should return
#' a data frame.  Defaults to \code{TRUE}.
#'
#' @return By default the function returns a data frame.  If
#' \code{data_frame = FALSE} the function returns a list of responses - 1 for each page of results - created by
#' \code{\link[httr]{GET}}
#'
#' @export
#'
#' @examples
#'
find_styles <- function(api_key,
                        style_id = NULL,
                        style_name = NULL,
                        category_id = NULL,
                        category_name = NULL,
                        data_frame = TRUE){

    # Define the base url for the styles endpoint at brewerydb.
    base_url <- base_url <- 'http://api.brewerydb.com/v2/styles'

    # Set up the query params and modify the url for the query.
    query_params <- list(key = api_key,
                         id = style_id,
                         name = style_name,
                         categoryId = category_id,
                         category = category_name,
                         format = 'json')

    query_url <- httr::modify_url(base_url, query = query_params)

    # Call the API and check the response.
    api_call <- httr::GET(query_url)
    httr::stop_for_status(api_call)

    # Check if there there is a data object in the response
    check_for_data_response(api_call)

    # Put response in a list to keep consistent with other functions. The style endpoint does not return multiple pages.
    api_response <- list(page1 = api_call)

    # If the data frame argument is true we use the json_parse function to
    # return a data frame.  Other wise we return the raw API response.
    if (data_frame) {
        df <- json_parse(api_response)
        return(df)
    } else {
        return(api_response)
    }

}
