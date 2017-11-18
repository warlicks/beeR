#' Parse JSON response and return a data frame.
#'
#' @param api_content an object of class "response" from \code{\link[httr]{GET}}
#'
#' @return returns a data frame
#'
#' @keywords internal
#'
#' @examples

json_parse <- function(api_content){
    # Convert the api content to raw JSON text
    raw_json <- httr::content(api_content, as = 'text', encoding = 'UTF-8')

    # Convert json to a data frame
    df <- jsonlite::fromJSON(raw_json, simplifyDataFrame = TRUE)$data
    return(df)
}
