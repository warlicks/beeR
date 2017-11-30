get_multiple_pages <- function(number_of_pages, api_response){

    # Store the first page response in a storage list.
    all_responses <- list(page1 = api_response)

    # Define vector for all the remanining pages
    page_sequence <- seq(2:number_of_pages)

    # Define variable with the URL from the original call
    original_url <- api_response$url

    # Loop through page sequence and api call for each.
    for (i in page_sequence){

        # Set up the url for the current page
        current_page_url <- httr::modify_url(original_url, query = list(p = i))

        # Call the url and check the response.
        current_page_response <- httr::GET(current_page_url)
        httr::stop_for_status(current_page_response,
                              task = paste('Error returning page',
                                           i,
                                           'of the results')
                              )

        # Append the results to the storage list
        list_name <- paste('page', i, sep = '')
        all_responses[[list_name]] <- current_page_response
    }

    return(all_responses)

}

