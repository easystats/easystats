# Top packages ------------------------------------------------------------

# top <- cranlogs::cran_top_downloads(when = "last-month", count=100)
# c("insight", "bayestestR", "parameters", "performance") %in% top$package


# All ---------------------------------------------------------------------

data <- as.data.frame(available.packages())


n <- 1000  # Number to get the download count from
pkgs <- sample(data$Package, n)



downloads <- data.frame()
for(i in 1:n){
  print(paste(i, "/", n))
  dl <- cranlogs::cran_downloads(packages=pkgs[[i]], when = "last-month")
  downloads <- rbind(downloads,
                     data.frame(Package = pkgs[[i]],
                                Downloads = sum(dl$count, na.rm=TRUE)))
}
write.csv(downloads, paste0("downloads_n", n, "_04_12_20.csv"))


easystats_dl <- data.frame()
for(pkg in c("insight", "bayestestR", "performance", "parameters", "effectsize", "modelbased", "correlation")){
  dl <- cranlogs::cran_downloads(packages=pkg, when = "last-month")
  easystats_dl <- rbind(easystats_dl,
                     data.frame(Package = pkg,
                                Downloads = sum(dl$count, na.rm=TRUE)))
}


library(ggplot2)
packages_colours <- c("insight" = unname(see::material_colors("orange")),
                      "bayestestR" = unname(see::material_colors("pink")),
                      "performance" = unname(see::material_colors("green")),
                      "see" = unname(see::material_colors("blue")),
                      "parameters" = unname(see::material_colors("purple")),
                      "effectsize" = unname(see::material_colors("brown")),
                      "modelbased" = unname(see::material_colors("lime")),
                      "correlation" = unname(see::material_colors("amber")))


p <- ggplot(downloads, aes(x=Downloads)) +
  geom_density(fill="grey", color="grey")+
  geom_vline(data=easystats_dl, aes(xintercept=Downloads, color=Package), size=1) +
  scale_color_manual(values=packages_colours) +
  scale_x_log10(expand = c(0, 0), labels = scales::comma) +
  scale_y_continuous(expand = c(0, 0)) +
  see::theme_modern() +
  ggtitle("Number of downloads last month")
p
ggsave("CRAN_downloads_lastmonth.png", p)

