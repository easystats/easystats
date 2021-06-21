source("https://raw.githubusercontent.com/DominiqueMakowski/hexwall/patch-1/hexwall.R")

path <- c("https://github.com/easystats/insight/raw/master/man/figures/logo.png",
          "https://github.com/easystats/bayestestR/raw/master/man/figures/logo.png",
          "https://github.com/easystats/parameters/raw/main/man/figures/logo.png",
          "https://github.com/easystats/effectsize/raw/main/man/figures/logo.png",
          "https://github.com/easystats/performance/raw/master/man/figures/logo.png",
          "https://github.com/easystats/modelbased/raw/master/man/figures/logo.png",
          "https://github.com/easystats/correlation/raw/master/man/figures/logo.png",
          "https://github.com/easystats/report/raw/master/man/figures/logo.png",
          "https://github.com/easystats/easystats/raw/master/man/figures/datawizard/logo.png",
          "https://github.com/easystats/easystats/raw/master/man/figures/easystats/logo.png",
          "https://github.com/easystats/see/raw/master/man/figures/logo.png")

hexwall(path,
        sticker_row_size = 3,
        sticker_width = 50,
        remove_small = FALSE,
        sort_mode = "color")
