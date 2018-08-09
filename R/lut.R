
#' Input/output look up table
#'
#' @docType class
#' @importFrom R6 R6Class
#' @name io_lut
#' @examples
#'
#'
#'
#' @exportClass io_lut
io_lut <- R6Class(
    'io_lut',
    public = list(
        reader = list(
            csv = read.csv
        ),
        converter = list(
            # these are some ridiculous examples but illustrate the utility of this member
            matrix = list(tibble = tibble::frame_matrix(),
                          vector = as.vector),
            array = list()
        ),
        writer = list(
            data.frame = list(csv = write.csv,
                              table = write.table)
        )
    )
)
