path <- c(
  "https://github.com/DominiqueMakowski/DominiqueMakowski.github.io/blob/master/content/authors/dominique-makowski/avatar.png?raw=true",
  "https://avatars.githubusercontent.com/u/26301769?v=4",
  "https://avatars.githubusercontent.com/u/35330040?v=4",
  "https://avatars.githubusercontent.com/u/11330453?v=4",
  "https://avatars.githubusercontent.com/u/4773225?v=4",
  "https://avatars.githubusercontent.com/u/13123390?v=4"
)

img <- magick::image_read(path) |>
  magick::image_resize("400x") |>
  magick::image_annotate(c("Makowski", "Lüdecke", "Ben-Shashar", "Patil", "Wiernik", "Thiérault"),
                         size = 30, color="white", gravity = "South") |>
  magick::image_montage(geometry = 'x400+0+0', tile = '6x1', shadow=FALSE)
img

magick::image_write(img, "maintainers.png", format="png")
