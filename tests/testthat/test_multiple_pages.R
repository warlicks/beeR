
context('Test the ability to handle multiple page responses')

key <- Sys.getenv("BREWERY_DB")

# Test that get_multiple_pages returns the correct number of responses. ----
## Set up API Call to test just the internal function and the number of records.
url <- httr::modify_url('http://api.brewerydb.com/v2/locations',
                        query = list(key = key,
                                     locality = 'Seattle',
                                     status = 'verified',
                                     format = 'json'))
response <- httr::GET(url)

total_pages <- httr::content(response)$numberOfPages
total_results <- httr::content(response)$totalResults


# Set Up API call to test find_brewerery returns the correct results ----
url2 <- httr::modify_url('http://api.brewerydb.com/v2/breweries',
                        query = list(key = key,
                                     established = '2011')
                        )

response2 <- httr::GET(url2)

brewery_pages <- httr::content(response2)$numberOfPages
brewery_results <- httr::content(response2)$totalResults

# Check that get multiple pages returns the correct number of pages ----
test_that('get_multiple_pages response returns right number of pgs', {
    expect_length(get_multiple_pages(number_of_pages = total_pages,
                                     response),
                  total_pages)
    expect_length(get_multiple_pages(number_of_pages = brewery_pages,
                                     response2),
                  brewery_pages)
})

# Check that the correct number of results are returned. ----

test_that('check that functions return the correct number of results w/ multipage', {
    expect_equal(nrow(find_locations(api_key = key,
                                     locality = 'Seattle')
                      ),
                total_results
                )

    expect_length(find_brewery(api_key = key,
                               established = '2011',
                               data_frame = FALSE),
                  brewery_pages)

    expect_equal(nrow(find_brewery(api_key = key,
                                   established = '2011')
                      ),
                 brewery_results
                 )
})
