library(hexSticker)
library(OpenImageR)
library(magick)
library(showtext)
library(plsr)


line_chart <- image_read("./data-raw/Sticker/linechart4.png")

sticker(
  subplot = line_chart, p_size = 10, p_color = "#197692", h_color = "#1D87A6", h_fill = "#8FF776",
  s_x = 1.25, s_y = 0.9, s_width = 2.5, s_height = 2,
  white_around_sticker = FALSE,
  package = "ftiRRRs"
) %>%
  print()
