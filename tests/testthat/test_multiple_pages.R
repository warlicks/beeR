
context('Test the ability to handle multiple page responses')

key <- Sys.getenv("BREWERY_DB")

# Test that get_multiple_pages returns the correct number of responses. ----
## Set up API Call to test just the internal function.
url <- httr::modify_url('http://api.brewerydb.com/v2/locations',
                        query = list(key = key,
                                     locality = 'Seattle',
                                     status = 'verified',
                                     format = 'json'))
response <- httr::GET(url)
total_pages <- httr::content(response)$numberOfPages


test_that('get_multiple_pages response returns right number of pgs',
          expect_length(get_multiple_pages(number_of_pages = total_pages,
                                           response),
                        total_pages)
          )
