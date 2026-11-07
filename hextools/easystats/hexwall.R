source("hexwall_function.R")

path <- c(
  # Top row
  "https://raw.githubusercontent.com/easystats/modelbased/master/man/figures/logo.png",
  "https://raw.githubusercontent.com/easystats/report/master/man/figures/logo.png",
  "https://raw.githubusercontent.com/easystats/see/master/man/figures/logo.png",
  "https://raw.githubusercontent.com/easystats/correlation/master/man/figures/logo.png",

  # Middle row
  "https://raw.githubusercontent.com/easystats/easystats/main/hextools/effectsize/logo.png",
  "https://raw.githubusercontent.com/easystats/easystats/main/man/figures/logo.png",
  "https://raw.githubusercontent.com/easystats/easystats/main/hextools/bayestestR/logo.png",

  # Bottom row
  "https://raw.githubusercontent.com/easystats/easystats/main/hextools/insight/logo.png",
  "https://raw.githubusercontent.com/easystats/easystats/main/hextools/parameters/logo.png",
  "https://raw.githubusercontent.com/easystats/easystats/main/hextools/performance/logo.png",
  "https://raw.githubusercontent.com/easystats/datawizard/master/man/figures/logo.png"
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
