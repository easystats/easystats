#' Welcome to the easyverse
#' @import insight performance bayestestR parameters correlation report estimate see
easystats_zen <- function(){
  print("Patience you must have my young padawan.")
}


#' Install the easystats suite from github
#' @import insight performance bayestestR parameters correlation report estimate see
#' @importFrom devtools install_github
install_easystats_latest <- function(){
  devtools::install_github(c("easystats/insight",
                             "easystats/bayestestR",
                             "easystats/performance",
                             "easystats/parameters",
                             "easystats/correlation",
                             "easystats/estimate",
                             "easystats/see",
                             "easystats/report"))
}

#' Install the dev branches of easystats from github
#' @import insight performance bayestestR parameters correlation report estimate see
#' @importFrom devtools install_github
install_easystats_dev <- function(){
  devtools::install_github(c("easystats/insight",
                             "easystats/bayestestR",
                             "easystats/performance",
                             "easystats/parameters",
                             "easystats/correlation",
                             "easystats/estimate",
                             "easystats/see",
                             "easystats/report"), ref="dev")
}