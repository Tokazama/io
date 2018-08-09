
#' Class to interact with default writers
#'
#' @param class_in the class of data to be written to file
#' @param extension file extension (class character)
#' @param f function that acts as writer
#'
#' @section Methods:
#' \code{$get(class_in, extension)} Get default writer
#' \code{$set(class_in, extension, f)} Set the default writer
#'
#' @docType class
#' @importFrom R6 R6Class
#' @name reader
#'
#' @exportClass writer
writer <- R6Class(
    'writer',
    public = list(
        lut = NULL,
        initialize = function() {
            self$lut <- io_lut$new()$writer
        },
        get = function(class_in, extension) {
            self$lut[[class_in]][[extension]]
        },
        set = function(class_in, extension, f) {2
            self$lut[[class_in]][[extension]] <- f
        }
    )
)


#' Write stuff out of R
#'
#'
#' @param object the data to be written out
#' @param the file name for the data to be written to
#' @param extension the file extension (e.g. '.csv') used to find the default writer
#' @param ... additional arguments to be passed to the writer
#' @param writer optional override writer to bypass default one
#'
#'
#' @export
write <- function(object, file, extension = tools::file_ext(file), ..., writer = NULL) {
    if (is.null(writer)) {
        class_in <- class(object)
        f <- writer$get(class_in, extension)
        if (is.null(f))
            stop(paste("Class", class_in, "objects currently have no default write method to", extension, "types."))
    } else
        f <- writer
    do.call(f, c(object, file, ...))
}
