library(insight)
library(bayestestR)
library(parameters)
library(performance)
library(correlation)
library(effectsize)
library(modelbased)
library(see)
library(report)

get_functions <- function() {
  all_funs <- data.frame()

  for (package in c("insight", "bayestestR", "parameters", "performance", "effectsize", "correlation", "modelbased", "see", "report")) {
    name <- ls(paste0("package:", package))

    functions <- data.frame(
      "Package" = package,
      "Name" = name
    )


    all_funs <- rbind(all_funs, functions)
  }

  all_funs <- all_funs[!duplicated(all_funs$Name), ]
  all_funs
}

get_distance <- function(s, s2) {
  parts1 <- unlist(stringr::str_split(s, "_"))
  parts2 <- unlist(stringr::str_split(s2, "_"))

  i <- 0
  for (part in parts1) {
    if (part %in% parts2) i <- i + 1
  }
  i
}






funs <- sort(get_functions()$Name)[1:200]
mat <- effectsize::normalize(adist(funs))
colnames(mat) <- row.names(mat) <- funs

for (row in 1:nrow(mat)) {
  for (col in 1:ncol(mat)) {
    d <- get_distance(funs[row], funs[col])
    mat[row, col] <- mat[row, col] + d
  }
}

diag(mat) <- NA



# Filter out small links
plot(estimate_density(mat))
mat[mat < 1] <- NA


library(ggraph)
library(igraph)
library(tidyverse)

p <- igraph::graph_from_adjacency_matrix(mat, mode = "directed", diag = FALSE, weighted = TRUE) %>%
  ggraph::ggraph(layout = "fr") +
  geom_edge_arc(aes(edge_width = weight), strength = 0.1, color = "#3F51B5", alpha = 0.66) +
  # geom_node_point(color) +
  geom_node_text(aes(label = name), color = "black", fontface = "bold", repel = TRUE) +
  scale_edge_width_continuous(range = c(0.0001, 0.75)) +
  theme_void() +
  theme(
    # panel.background = element_rect(fill = "#001429"),
    legend.position = "none"
  )
# p
ggsave("network_functions.png", p, width = 15, height = 15, dpi = 450)
