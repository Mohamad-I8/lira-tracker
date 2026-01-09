web_layout = {
  LinearLayout,
  orientation = "vertical",
  layout_width = "match_parent",
  layout_height = "match_parent",
  {
    LinearLayout,
    gravity = "center_vertical", 
    orientation = "horizontal",
    background = "#05423A",
    layout_width = "match_parent",
    layout_height = "56dp", 
    paddingLeft = "8dp",
    paddingRight = "8dp",
    {
      Button,
      id = "exit_btn",
      contentDescription = "إغلاق",
      background = ICONS_DIR .. "exit.png",
      layout_width = "32dp",
      layout_height = "32dp",
      onClick = function()
        web_dlg.dismiss()
      end
    },
    {
      TextView,
      text = "أسعار الصرف من موقع الليرة اليوم",
      textColor = "#ffffff",
      textSize = 12,
      typeface = Typeface.DEFAULT_BOLD,
      singleLine = true,
      gravity = "center_vertical",
      layout_width = "match_parent",
      layout_height = "match_parent",
      layout_weight = 1,

    },
  },
  {
    WebView,
    id = "web",
    layout_width = "match_parent",
    layout_height = "match_parent",
  }
}
