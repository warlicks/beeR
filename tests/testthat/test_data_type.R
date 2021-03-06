library(beeR)

context('Check Returned Data Types')

key <- Sys.getenv("BREWERY_DB")

test_that('find_breweries returns correct data types', {
    # Check That a data frame is returned when `data_frame = TRUE`
    expect_is(find_brewery(api_key = key,
                           name = 'DC Brau Brewing Company'),
              'data.frame')
    expect_is(find_brewery(api_key = key,
                           name = 'DC Brau Brewing Company',
                           data_frame = FALSE),
              'list')
})

test_that('find_locations returns correct data types', {
    #Check that a data frame is returned when `data_frame = TRUE`
    expect_is(find_locations(api_key = key,
                             locality = 'Seattle'),
              'data.frame'
    )
    expect_is(find_locations(api_key = key,
                             locality = 'Seattle',
                             data_frame = FALSE),
              'list'
    )
})

test_that('find_categories returns the correct data types',{
    # Check that a data frame is retunred when `data_frame = TRUE`
    expect_is(find_categories(api_key = key), 'data.frame')

    # Check that a httr response is returned when `data_frame = FALSE`
    expect_is(find_categories(api_key = key, data_frame = FALSE), 'list')
})

test_that('find_styles returns the correct data types',{
    # Check that a data frame is retunred when `data_frame = TRUE`
    expect_is(find_styles(api_key = key), 'data.frame')

    # Check that a list of httr responses is returned when `data_frame = FALSE`
    expect_is(find_styles(api_key = key, data_frame = FALSE), 'list')
})

test_that('find_beer returns the correct data types', {
    # Check that a data frame is retunred when `data_frame = TRUE`
    expect_is(find_beer(api_key = key, name = 'Stoup Northwest Red'),
              'data.frame')
    # Check that a list of httr response is returned when `data_frame = FALSE`
    expect_is(find_beer(api_key = key,
                        name = 'Stoup Northwest Red',
                        data_frame = FALSE),
              'list')
})

test_that('find_beer_ingredients returns the correct data types',{
    # Check that a data frame is retunred when `data_frame = TRUE`
    expect_is(find_beer_ingredients(key, 'WHQisc'), 'data.frame')

    # Check that a list of httr response is returned when `data_frame = FALSE`
    expect_is(find_beer_ingredients(key,
                                    'WHQisc',
                                    data_frame = FALSE),
              'list')

})
