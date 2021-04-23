library(tidyverse)
library(devtools)
library(miniCRAN)
library(igraph)
library(ggnetwork)
library(intergraph)
pkg <- devtools::as.package(".")
# dependencies <- unlist(strsplit(paste(pkg$imports, "\n", pkg$depends), split = "\n"))[-1]
# dependencies <- trimws(gsub("\\n| \\(.+\\)|,", "", dependencies))
dependencies <- c(
  "insight", "bayestestR", "performance", "parameters", "see",
  "correlation", "modelbased", "report", "effectsize"
)
dependency_graph <- miniCRAN::makeDepGraph(dependencies, suggests = FALSE, enhances = FALSE)
class(dependency_graph) <- "igraph"
dependency_graph <- dependency_graph + igraph::vertices(pkg$package) + igraph::edges(as.vector(rbind(dependencies, pkg$package)))
dependency_graph <- igraph::simplify(dependency_graph)
edge_list <- igraph::get.edgelist(dependency_graph)
# dependency_graph <- igraph::graph(rbind(edge_list[, 2], edge_list[, 1]))
dependency_graph_df <- ggnetwork::ggnetwork(
  dependency_graph,
  layout = "fruchtermanreingold",
  arrow.gap = 0.015,
  layout.par = list(niter = 5000)
)
dependency_graph_df$package <- dependency_graph_df$vertex.names
dependency_graph_df$face <- ifelse(dependency_graph_df$package == pkg$package, "bold", "plain")
dependency_graph_df$n_dependencies <- as.vector(table(gsub("\\|.+", "", attr(igraph::E(dependency_graph), "vnames")))[as.character(dependency_graph_df$package)])
dependency_graph_df$n_dependencies[is.na(dependency_graph_df$n_dependencies)] <- 0
dependency_graph_df$importance <- as.vector(table(gsub(".+\\|", "", attr(E(dependency_graph), "vnames")))[as.character(dependency_graph_df$package)])
dependency_graph_df$importance[is.na(dependency_graph_df$importance)] <- 0
max_downstream_deps <- max(dependency_graph_df$importance)
dependency_graph_df$importance <- dependency_graph_df$importance / max_downstream_deps
dependency_graph_df$importance <- abs(1 - dependency_graph_df$importance)
dependency_graph_df <- as.data.frame(lapply(dependency_graph_df, as.vector))
ggplot(dependency_graph_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_nodes(aes(color = n_dependencies), size = 6.5, alpha = 0.4) +
  geom_edges(arrow = arrow(length = unit(4, "pt"), type = "closed"), color = grey(0.4)) +
  geom_nodelabel_repel(
    aes(label = package, fontface = face, color = n_dependencies),
    box.padding = unit(8, "pt")
  ) +
  geom_nodes(aes(color = n_dependencies, size = 7 * importance)) +
  scale_color_distiller(palette = "Spectral") +
  scale_size(labels = function(x) abs(max_downstream_deps - ceiling(x / 7 * max_downstream_deps))) +
  theme_blank(legend.position = "top") +
  guides(
    size = guide_legend(title = "Downstream dependencies", title.position = "top", title.hjust = 0.5, label.position = "bottom", label.hjust = 0.5),
    color = guide_colorbar(title = "Upstream dependencies", title.position = "top", title.hjust = 0.5, barwidth = unit(130, "pt"), barheight = unit(4, "pt"))
  )
