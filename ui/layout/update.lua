function show_update_dialog(ver, new_text)
  return {
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
      padding="8dp",
      gravity = "center_vertical",
      {
        TextView,
        text = "يتوفر تحديث جديد",
        textSize = 22,
        textColor = "#ffffff",
        typeface=Typeface.DEFAULT_BOLD,
        layout_width = "match_parent",
        gravity = "center",
      },
    },
    {
      ScrollView,
      layout_width = "match_parent",
      {
        LinearLayout,
        id = "info_container",
        orientation="vertical",
        gravity="center",
        layout_width="match_parent",
        padding="8dp",
        layout_margin="8dp",
        {
          TextView,
          text = "الإصدار: " .. ver,
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          TextView,
          text = "ما الجديد؟",
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          TextView,
          text = new_text,
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          LinearLayout,
          id = "btn_container",
          orientation="horizontal",
          layout_width = "match_parent",       
          {
            Button,
            id = "cancel_btn",
            text = "إلغاء",
            layout_marginLeft="5dp",          
            layout_width = "match_parent",
            layout_weight = 1,
            onClick = function()
              update_dlg.dismiss()
            end
          },
          {
            Button,
            id = "download_btn",
            text = "تحديث",
            layout_marginLeft="5dp",           
            layout_width = "match_parent",           
            layout_weight = 1,
            onClick = function()
              download_update(online_data.download_url)
            end
          },
        },
      },
    },
  }
end