test = list(
  name = "Question 5",
  cases = list(
    ottr::TestCase$new(
      hidden = FALSE,
      name = NA, 
      points = 0.5,
      success_message = "well done! You have successfully filtered the data to include observations whose Arrival Delays falls within the 1st and 90th quantiles.",
      failure_message = "Almost there! Ensure you have filtered the **df_flights** data to only include rows where the entry for **ArrDelay** Column is greater than **arrdelay_01pctile** and less than **arrdelay_90pctile**",
      code = {
        ## TEST ##

        test_that('there are no outliers', {
          expect_equal(sum(df_flights$ArrDelay < arrdelay_01pctile), 0)
          expect_equal(sum(df_flights$ArrDelay > arrdelay_90pctile), 0)
        })
      }
    )
  )
)
