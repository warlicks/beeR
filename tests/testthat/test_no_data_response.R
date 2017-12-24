library(beeR)

context('Check When No Data Is Returned')

key <- Sys.getenv("BREWERY_DB")
error <- 'No data found for the provided query paramenters'

test_that('An Error Is Returned When No Data is Returned',{
  expect_error(find_brewery(key, name = 'Ravena'),
               error)

  expect_error(find_locations(key, locality = 'Fort Dodge'),
               error)

  expect_error(find_categories(key, name = 'Seattle Style'),
               error)

  expect_error(find_styles(key, style_name = 'No Name Beer' ),
               error)

  #expect_error(find_beer(key, name = ))
})
