#' Calculate parameters required in a Dirichlet distribution
#'
#' @description
#' \code{dirichlet_params} calculates the 'alpha' values of a Dirichlet distribution from the mean values
#' and one variance value.
#'
#' @param mean \code{numerical} vector, same length as \code{variance}, containing the mean values of
#' component of a Dirichlet distribution.
#' @param variance \code{numerical} vector, with only one non-NA element with a \code{variance} value.
#'
#' @details
#' Input \code{mean} vector must contain mean values for each component of the Dirichlet distribution.
#' If one value is missing (signaled with a NA) it is calculated from the sum of all other mean values.
#' In turn, only one \code{variance} value must be introduced and all other elements in the \code{variance}
#' vector must have an \code{NA}.
#'
#' @returns
#' The corresponding \code{alpha} values for the Dirichlet distribution. If the \code{alpha} values are
#' negative the variance should be decreased. A warning is issued in this case.
#'
#' @export
#'
#' @examples
#' # Mean and variance values as input.
#' m <- c(.3, .23,.27, .2)
#' v <- c(NA, .1, NA, NA)
#' alpha <- dirichlet_params(m, v)
#'
#' # Calculate mean values from alpha.
#' print(alpha/sum(alpha))
#'
#' # Calculate variance values from alpha.
#' alpha0 <- sum(alpha)
#' beta <- alpha / alpha0
#' print(beta*(1-beta)/(1+alpha0))
#'
dirichlet_params <- function(mean = mean, variance = variance) {


  # Indices and checks.
  if (length(mean) != length(variance)) stop("Input vectors must have the same length")
  index_mean <- is.na(mean)
  tot <- sum(index_mean)
  if (tot > 1) {
    stop("There must be at least 2 mean values")
  } else if (tot == 1) {
    if (sum(mean, na.rm = TRUE) >= 1) stop("Mean values are too large")
    mean[index_mean] <- 1 - sum(mean, na.rm = TRUE)
  }

  index_variance <- !is.na(variance)
  if (sum(index_variance) != 1) stop("There must be only 1 variance value")


  # Calculations.
  alpha0 <- mean[index_variance] * (1 - mean[index_variance]) / variance[index_variance] - 1
  alpha <- mean *alpha0
  if (any(alpha < 0)) warning("'alpha' values are negative due to a very large variance")

  return(alpha)

}
