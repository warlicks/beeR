#' Check if the response from the API call includes data.
#'
#' @param api_response a response object created by \code{\link[httr]{GET}}.
#' More specifically it is the respones from the original API call which
#' returned multiple result pages
#'
#' @return A logical object indicating if data is part of the response object
#'
#' @keywords internal
#'

check_for_data_response <- function(api_response){
  # Set Up error message
  message <- paste0('No data found for the provided query paramenters. ',
                    'Check the provided query parameters.')

  # Find names of the objects included in the API response
  response_objects_names <- httr::content(api_response)


  assertthat::assert_that(
    assertthat::has_name(response_objects_names, 'data'),
    msg = message)
}
