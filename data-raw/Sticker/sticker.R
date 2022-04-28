library(hexSticker)
library(OpenImageR)
library(magick)
library(plsr)

line_chart <- image_read("./data-raw/Sticker/linechart4.png")

sticker(
  subplot = line_chart, p_size = 20, p_color = "#4365F9", h_color = "#4365F9", h_fill = "#42EB1A",
  s_x = 1.25, s_y = 0.9, s_width = 2.5, s_height = 2,
  white_around_sticker = FALSE,
  package = "ftiRRRs"
) %>%
  print()
