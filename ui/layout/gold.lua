gold_layout = {
  LinearLayout,
  orientation = "vertical",
  background = "#121212",
  layout_height = "match_parent",
  layout_width = "match_parent",
  {
    LinearLayout,
    orientation = "horizontal",
    background = "#05423A",
    layout_height = "wrap_content",
    layout_width = "match_parent",
    padding = "8dp",
    gravity = "center_vertical",
    {
      LinearLayout,
      orientation = "horizontal",
      layout_width = "wrap_content",
      layout_height = "wrap_content",
      gravity = "left",
      {
        Button,
        id = "exit_btn",
        contentDescription = "إغلاق",
        background = ICONS_DIR .. "exit.png",
        layout_width = "32dp",
        layout_height = "32dp",
        onClick= function()
          gold_dlg.dismiss()       
        end
      },
      {
        Button,
        id = "refresh_gold_btn",
        contentDescription = "تحديث أسعار الذهب",
        background = ICONS_DIR .. "refresh.png",
        layout_width = "32dp",
        layout_height = "32dp",
        layout_marginLeft = "12dp",
        onClick = function()  
          fetch_gold(false)
       end
      },
    },
    {
      TextView,
      text = "أسعار الذهب",
      textSize = 22,
      textColor = "#ffffff",
      typeface = Typeface.DEFAULT_BOLD,
      layout_width = "0dp",
      layout_weight = 1,
      gravity = "right|center_vertical",
    },
  },
  {
    ScrollView,
    layout_width="match_parent",
    {
      LinearLayout,
      id = "gold_container",
      orientation="vertical",
      gravity="center",
      layout_width="match_parent",
      padding="8dp",
      layout_margin="8dp",
    },
  },
}
