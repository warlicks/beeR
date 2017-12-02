#' Parse JSON response and return a data frame.
#'
#' @param api_content a list.  Each object in the list should of class "response" from \code{\link[httr]{GET}}
#'
#' @return returns a data frame
#'
#' @keywords internal
#'
#' @examples

json_parse <- function(response_list){
    # Convert the api content to raw JSON text
    all_json <- lapply(response_list,
                       httr::content,
                       as = 'text',
                       encoding = 'UTF-8')

    # Convert elements to data frame
    all_df <- lapply(all_json, jsonlite::fromJSON, simplifyDataFrame = TRUE)

    # Extract the data frame portion of the response
    all_df2 <- lapply(all_df, function(x){x[['data']]})

    # Flatten the nested data frames
    all_flattend_df <- lapply(all_df2, jsonlite::flatten)

    # Bind all the data frames together
    final_df <- dplyr::bind_rows(all_flattend_df)

    return(final_df)
}
