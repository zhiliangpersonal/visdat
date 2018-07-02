#' Visually compare two dataframes and see where they are different.
#'
#' `vis_compare`, like the other `vis_*` families, gives an at-a-glance ggplot
#'   of a dataset, but in this case, hones in on visualising **two** different
#'   dataframes of the same dimension, so it takes two dataframes as arguments.
#'
#' @param df1 The first dataframe to compare
#'
#' @param df2 The second dataframe to compare to the first.
#'
#' @return `ggplot2` object displaying which values in each data frame are
#'   present in each other, and which are not.
#'
#' @seealso [vis_miss()] [vis_dat()] [vis_guess()] [vis_expect()] [vis_cor()]
#'
#' @examples
#'
#' # make a new dataset of iris that contains some NA values
#' aq_diff <- airquality
#' aq_diff[1:10, 1:2] <- NA
#' vis_compare(airquality, aq_diff)
#' @export
vis_compare <- function(df1,
                        df2){

  # could add a parameter, "sort_match", to help with
  # sort_match logical TRUE/FALSE.
  # TRUE arranges the columns in order of most matches.

  # make a TRUE/FALSE matrix of the data.
  # Tells us whether it is the same (true) as the other dataset, or not (false)

  if (!identical(dim(df1), dim(df2))){
    stop("Dimensions of df1 and df2 are not the same. vis_compare requires dataframes of identical dimensions.")
  }

  v_identical <- Vectorize(identical)

  df_diff <- purrr::map2(df1, df2, v_identical) %>%
    dplyr::as_data_frame()

  d <-
  df_diff %>%
    as.data.frame() %>%
    purrr::map_df(compare_print) %>%
    vis_gather_() %>%
    dplyr::mutate(value_df1 = vis_extract_value_(df1),
                  value_df2 = vis_extract_value_(df2))

  # d$value_df1 <- tidyr::gather_(df1, "variables", "value", names(df1))$value
  # d$value_df2 <- tidyr::gather_(df2, "variables", "value", names(df2))$value

  # then we plot it
  ggplot2::ggplot(data = d,
                  ggplot2::aes_string(
                    x = "variable",
                    y = "rows",
                    # text assists with plotly mouseover
                    # currently this text argument prevents it from being used
                    # in the boilerplate
                    text = c("value_df1", "value_df2"))) +
    ggplot2::geom_raster(ggplot2::aes_string(fill = "valueType")) +
    # change the colour, so that missing is grey, present is black
    # scale_fill_discrete(name = "",
    #                     labels = c("Different",
    #                                "Missing",
    #                                "Same")) +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45,
                                     vjust = 1,
                                     hjust = 1)) +
    ggplot2::labs(x = "",
         y = "Observations",
         # this prevents it from being used in the boilerplate
         fill = "Cell Type") +
    # ggplot2::scale_x_discrete(limits = names(df_diff)) +
    ggplot2::scale_fill_manual(limits = c("same",
                                 "different"),
                      breaks = c("same", # red
                                 "different"), # dark blue
                      values = c("#fc8d59", # Orange
                                 "#91bfdb"), # blue
                      na.value = "grey") +
  # flip the axes
  ggplot2::scale_y_reverse() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(hjust = 0.25)) +
    ggplot2::scale_x_discrete(position = "top",
                              limits = names(df_diff))
}

#' (Internal) A utility function for `vis_compare`
#'
#' `compare_print` is an internal function that takes creates a dataframe with
#'   information about where there are differences in the dataframe. This
#'   function is used in `vis_compare`. It evaluates on the data `(df1 == df2)`
#'   and (currently) replaces the "true" (the same) with "Same"
#'   and FALSE with "Different", unless it is missing (coded as NA), in which
#'   case it leaves it as NA.
#'
#' @param x a vector
#'
#'
compare_print <- function(x){

  dplyr::if_else(x == "TRUE",
                 true = "same",
                 false = "different",
                 missing = "missing")


} # end function
