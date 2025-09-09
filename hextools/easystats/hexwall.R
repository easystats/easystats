source("hexwall_function.R")

path <- c(
  # Top row
  "https://github.com/easystats/modelbased/raw/master/man/figures/logo.png",
  "https://github.com/easystats/report/raw/master/man/figures/logo.png",
  "https://github.com/easystats/see/raw/master/man/figures/logo.png",
  "https://github.com/easystats/correlation/raw/master/man/figures/logo.png",

  # Middle row
  "https://github.com/easystats/effectsize/raw/main/man/figures/logo.png",
  "https://github.com/easystats/easystats/raw/master/man/figures/easystats/logo.png",
  "https://github.com/easystats/bayestestR/raw/master/man/figures/logo.png",

  # Bottom row
  "https://github.com/easystats/insight/raw/master/man/figures/logo.png",
  "https://github.com/easystats/parameters/raw/main/man/figures/logo.png",
  "https://github.com/easystats/performance/raw/master/man/figures/logo.png",
  "https://github.com/easystats/easystats/raw/master/man/figures/datawizard/logo.png"
)

# Create hexagonal logo wall
logo_wall <- hexwall(
  path,
  sticker_row_size = 4,
  sticker_width = 300,
  remove_small = FALSE,
  sort_mode = "filename"
)

image_write(logo_wall, "logo_wall.png", density = 300)
