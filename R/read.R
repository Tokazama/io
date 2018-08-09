
#' Class to interact with default readers
#'
#'
#' @param extension file extension (class character)
#' @param f function that acts as reader
#'
#' @section Methods:
#' \code{$get(extension)} Get default reader for a given extension
#' \code{$set(extension, f)} Set the default reader
#'
#' @docType class
#' @importFrom R6 R6Class
#' @exportClass reader
reader <- R6Class(
    'reader',
    public = list(
        lut = NULL,
        initialize = function() {
            self$lut <- io_lut$new()$reader
        },
        get = function(extension) {
            self$lut[[extension]]
        },
        set = function(extenseion, f) {
            self$lut$extension <- f
        }
    )
)


#' Read stuff into R
#'
#'
#' @param file the name of the file which the data are to be read from
#' @param extension the file extension (e.g. '.csv') used to find the default reader
#' @param ... additional arguments to be passed to the reader
#' @param reader optional override reader to bypass default one
#'
#' @examples
#' tf <- tempfile()
#' writeLines(test1, tf)
#' df <- read(tf, fill = TRUE)
#' @export

read <- function(file, extension = tools::file_ext(file), ..., reader = NULL) {
    if (is.null(reader)) {
        f <- reader$get(extension)
        if (is.null(f))
            stop(paste("File extension", extension, "currently has no default read method."))
    } else
        f <- reader
    do.call(f, c(file, ...))
}
