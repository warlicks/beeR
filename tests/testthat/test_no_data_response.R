library(beeR)

context('Check When No Data Is Returned')

key <- Sys.getenv("BREWERY_DB")
error <- 'No data found for the provided query paramenters'

test_that('An Error Is Returned When No Data is Returned',{
  expect_error(find_brewery(key, name = 'Ravena'),
               error)

  expect_error(find_locations(key, locality = 'Fort Dodge'),
               error)

  expect_error(find_beer(key, name = "Sean's Fake Beer"), error)

  expect_error(find_beer_ingredients(key, '2zmsbt'), error)

  ## This test is not needed.  When we put in a fake category the API returns all
  ## categories rather than no data.
  #expect_error(find_categories(key, name = 'Seattle Style'), error)

  ## This test is not needed.  When we put in a fake style the API returns all
  ## categories rather than no data.
  #expect_error(find_styles(key, style_name = 'No Name Beer' ),error)

})
