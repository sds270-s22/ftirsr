library(hexSticker)
library(OpenImageR)
library(magick)
library(plsr)

line_chart <-image_read("./data-raw/Sticker/linechart2.png")

sticker(subplot = line_chart,
        filename="Sticker/sticker.png" )

sticker(line_chart,
        package="hexSticker", p_size=20, s_x=.8, s_y=.6, s_width=1.4, s_height=1.2,
        filename="inst/figures/baseplot.png")

sticker(subplot = line_chart, p_size=20, p_color = "#43828D", h_color = "#43828D", h_fill = "#6BDA63",
        s_x = 1, s_y = .8, s_width = 3, s_height = 3,
        white_around_sticker = TRUE,
        package = "ftiRRRs")%>%
  print()


line_chart %>% print()
