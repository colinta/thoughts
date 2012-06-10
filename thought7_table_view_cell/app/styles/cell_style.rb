
Teacup::Stylesheet.new :cell_sheet do

  style :icon,
    frame:  [[5, 5], [40, 40]]

  style :title,
    font:   :system.uifont(17),
    frame:  [[50, 0], [245, 20]]

  style :description,
    frame:  [[50, 20], [245, 30]],
    font:   :system.uifont(12),
    textColor:  :gray.uicolor,
    lineBreakMode:  UILineBreakModeWordWrap,
    numberOfLines:  0

  style :logo,
    left:    295,
    width:   20,
    height:  20

  style :logo1, extends: :logo,
    top:  5

  style :logo2, extends: :logo,
    top:  25

end
