library(hexSticker)
library(OpenImageR)
library(magick)
library(plsr)

line_chart <- image_read("./data-raw/Sticker/linechart4.png")

sticker(
  subplot = line_chart, p_size = 20, p_color = "#4365F9", h_color = "#4365F9", h_fill = "#42EB1A", h_size = 0.9,
  s_x = 1.35, s_y = 0.55, s_width = 1000, s_height = 2, spotlight = FALSE,
  white_around_sticker = TRUE,
  package = "ftiRRRs"
) %>%
  print()
