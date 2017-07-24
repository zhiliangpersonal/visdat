#' A small toy dataset of imaginary people
#'
#' A dataset containing information about some randomly generated people,
#'   created using the excellent `wakefield` package. It is created as
#'   deliberately messy dataset.
#'
#' @format A data frame with 5000 rows and 11 variables:
#' \describe{
#'   \item{ID}{Unique identifier for each individual, a sequential character
#'     vector of zero-padded identification numbers (IDs). see ?wakefield::id}
#'   \item{Race}{Race for each individual, "Black", "White", "Hispanic",
#'     "Asian", "Other", "Bi-Racial", "Native", and "Hawaiin", see
#'     ?wakefield::race}
#'   \item{Age}{Age of each individual, see ?wakefield::age}
#'   \item{Sex}{Male or female, see ?wakefield::sex }
#'   \item{Height(cm)}{Height in centimeters, see ?wakefield::height}
#'   \item{IQ}{vector of intelligence quotients (IQ), see ?wakefield::iq}
#'   \item{Smokes}{whether or not this person smokes, see ?wakefield::smokes}
#'   \item{Income}{Yearly income in dollars, see ?wakefield::income}
#'   \item{Died}{Whether or not this person has died yet., see ?wakefield::died}
#' }
#'
"typical_data"
