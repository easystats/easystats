# Dependencies
library(magick)

# path:             The path to a folder of hexagon stickers
# sticker_row_size: The number of stickers in the longest row
# sticker_width:    The width of each sticker in pixels
# remove_small:     Should hexagons smaller than the sticker_width be removed?
# coords:           A data.frame of coordinates defining the placement of hexagons
# scale_coords:     Should the coordinates be scaled to the hexagon size?
# remove_size:      Should hexagons of an abnormal size be removed?
# sort_mode:        How should the files be sorted?
hexwall <- function(
  path,
  sticker_row_size = 16,
  sticker_width = 500,
  remove_small = TRUE,
  total_stickers = NULL,
  remove_size = TRUE,
  coords = NULL,
  scale_coords = TRUE,
  sort_mode = c("filename", "random", "color", "colour")
) {
  sort_mode <- match.arg(sort_mode)

  # Collect sticker paths
  sticker_paths <- c()
  for (p in path) {
    if (tools::file_ext(p) == "") {
      sticker_paths <- c(sticker_paths, file.path(p, list.files(p)))
    } else {
      sticker_paths <- c(sticker_paths, p)
    }
  }

  # Load, and trim stickers
  stickers <- lapply(sticker_paths, function(p) {
    img <- switch(
      tools::file_ext(p),
      svg = image_read_svg(p),
      pdf = image_read_pdf(p),
      image_read(p)
    )
    image_trim(img)
  })
  names(stickers) <- sticker_paths

  # Filter low resolution stickers
  low_res <- if (remove_small) {
    sapply(stickers, function(img) {
      image_info(img)$width < (sticker_width - 1) / 2 &&
        image_info(img)$format != "svg"
    })
  } else {
    rep(FALSE, length(stickers))
  }

  # Scale stickers to target width
  stickers <- lapply(stickers, function(img) image_scale(img, sticker_width))

  # Filter incorrectly sized stickers (compare against cross-sticker median)
  heights <- sapply(stickers, function(img) image_info(img)$height)
  bad_size <- if (remove_size) {
    med_h <- median(heights)
    heights < (med_h - 2) | heights > (med_h + 2)
  } else {
    rep(FALSE, length(stickers))
  }

  # Remove bad stickers
  sticker_rm <- low_res | bad_size
  stickers <- stickers[!sticker_rm]

  if (any(sticker_rm)) {
    message(sprintf(
      "Automatically removed %i incompatible stickers: %s",
      sum(sticker_rm),
      paste0(names(sticker_rm[sticker_rm]), collapse = ", ")
    ))
  }

  if (is.null(total_stickers)) {
    total_stickers <- if (!is.null(coords)) NROW(coords) else length(stickers)
  }

  # Coerce all stickers to identical dimensions
  sticker_height <- median(sapply(stickers, function(img) {
    image_info(img)$height
  }))
  stickers <- lapply(stickers, function(img) {
    image_resize(img, paste0(sticker_width, "x", sticker_height, "!"))
  })

  # Repeat/truncate to total_stickers
  stickers <- rep_len(stickers, total_stickers)

  if (sort_mode == "random") {
    stickers <- sample(stickers)
  } else if (sort_mode %in% c("color", "colour")) {
    hue <- sapply(stickers, function(img) {
      px <- image_data(image_resize(img, "1x1!"))
      col <- paste0("#", paste0(px[,, 1], collapse = ""))
      as(colorspace::hex2RGB(col), "HSV")@coords[, 1]
    })
    stickers <- stickers[order(hue)]
  }

  if (is.null(coords)) {
    # Compute row lengths for the hex-offset grid
    sticker_col_size <- floor(length(stickers) / (sticker_row_size - 0.5))
    row_lens <- rep(
      c(sticker_row_size, sticker_row_size - 1),
      length.out = sticker_col_size
    )
    row_lens[length(row_lens)] <- row_lens[length(row_lens)] -
      (length(stickers) - sum(row_lens))

    # Build each row as a single appended image
    idx <- 0L
    sticker_rows <- lapply(row_lens, function(n) {
      row_imgs <- stickers[(idx + 1L):(idx + n)]
      idx <<- idx + n
      image_append(Reduce(c, row_imgs))
    })

    # Position each row on a full-canvas-sized transparent layer, then flatten.
    # image_extent offset is ignored in some ImageMagick builds, so we use
    # image_append to manually pad each row to the full canvas size.
    canvas_w <- sticker_row_size * sticker_width
    canvas_h <- ceiling(
      sticker_height + (sticker_col_size - 1) * sticker_height / 1.33526
    )

    place_row <- function(img, x_off, y_off) {
      h <- image_info(img)$height
      w <- image_info(img)$width
      # Left padding
      if (x_off > 0L) {
        img <- image_append(c(image_blank(x_off, h, "none"), img))
      }
      # Right padding
      right_w <- canvas_w - x_off - w
      if (right_w > 0L) {
        img <- image_append(c(img, image_blank(right_w, h, "none")))
      }
      # Top padding
      if (y_off > 0L) {
        img <- image_append(
          c(image_blank(canvas_w, y_off, "none"), img),
          stack = TRUE
        )
      }
      # Bottom padding
      bottom_h <- canvas_h - y_off - h
      if (bottom_h > 0L) {
        img <- image_append(
          c(img, image_blank(canvas_w, bottom_h, "none")),
          stack = TRUE
        )
      }
      img
    }

    positioned <- lapply(seq_along(sticker_rows), function(i) {
      x_off <- ((i - 1L) %% 2L) * sticker_width / 2
      y_off <- round((i - 1L) * sticker_height / 1.33526)
      place_row(sticker_rows[[i]], x_off, y_off)
    })

    # Set background to transparent so image_flatten uses a transparent canvas,
    # not the default white one.
    image_flatten(image_background(
      Reduce(c, positioned),
      "none",
      flatten = FALSE
    ))
  } else {
    sticker_pos <- coords
    if (scale_coords) {
      scale_col <- function(x) {
        x <- x - min(x)
        dx <- diff(sort(unique(abs(x))))
        x / min(dx[dx != 0])
      }
      sticker_pos$x <- scale_col(sticker_pos$x) * sticker_width / 2
      sticker_pos$y <- abs(
        scale_col(sticker_pos$y) - max(scale_col(sticker_pos$y))
      ) *
        sticker_height /
        1.33526
    }

    canvas_w <- max(sticker_pos$x) + sticker_width
    canvas_h <- max(sticker_pos$y) + sticker_height

    positioned <- lapply(seq_len(NROW(sticker_pos)), function(i) {
      image_extent(
        stickers[[i]],
        paste0(
          canvas_w,
          "x",
          canvas_h,
          "+",
          sticker_pos$x[i],
          "+",
          sticker_pos$y[i]
        ),
        color = "none"
      )
    })

    image_flatten(Reduce(c, positioned))
  }
}
