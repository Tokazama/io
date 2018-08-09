
#' Class to interact with default converters
#'
#' @param class_in class to be converted
#' @param class_out class to be converted to
#' @param f function that acts as converter
#'
#' @section Methods:
#' \code{$get(class_in, class_out)} Get default converter for a given conversion from \code{class_in} to \code{class_out}
#' \code{$set(class_in, class_out, f)} Set the default converter
#'
#' @docType class
#' @importFrom R6 R6Class
#'
#' @exportClass converter
converter <- R6Class(
    'converter',
    public = list(
        lut = NULL,
        initialize = function() {
            self$lut <- io_lut$new()$converter
        },
        get = function(class_in, class_out) {
            self$lut[[class_in]][[class_out]]
        },
        set = function(class_in, class_out, f) {
            self$lut[[class_in]][[class_out]] <- f
        }
    )
)

#' Convert object of on class to another
#'
#'
#' @param object object to be converted
#' @param class_out class to be converted to
#' @param ... additional arguments to be passed to the converter
#' @param converter optional override converter to bypass default one
#'
#' @export
convert <- function(object, class_out = NULL, ..., converter = NULL) {
    if (is.null(converter)) {
        class_in <- class(object)
        converter$get(class_in, class_out)
        if (is.null(f))
            stop(paste("Conversion from", class_in, "to", class_out, "currently has no default convert method."))
    } else
        f <- converter
    f(object, ...)
    do.call(f, c(object, ...))
}
