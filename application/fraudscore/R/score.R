#' score
#' @description runs fraud example benchmark
#' @param balance balance
#' @param numTrans number of transactions
#' @param creditLine credit line
#' @export
score <- function(balance, numTrans, creditLine) 
{
    score <- data.frame(balance = balance, numTrans = numTrans, creditLine = creditLine)
    x <- predict(fraudModel, score)
    as.double(x)
}


