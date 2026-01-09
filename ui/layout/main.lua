main_layout = {
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
      text = "Lira Tracker",
      textSize = 22,
      textColor = "#ffffff",
      typeface=Typeface.DEFAULT_BOLD,
      layout_width = "match_parent",
      layout_weight = 1,
    },
    {
      Button,
      id = "refresh_btn",
      contentDescription = "تحديث أسعار الصرف",
      background = ICONS_DIR .. "refresh.png",
      layout_width = "32dp",
      layout_height = "32dp",
      onClick = function()
        fetch_currencies(false)
      end
    },
    {
      Button,
      id = "exit_btn",
      contentDescription = "إغلاق",
      background = ICONS_DIR .. "exit.png",
      layout_width = "32dp",
      layout_height = "32dp",
      onClick = function()
        dlg.dismiss()
      end
    },
  },
  {
    ScrollView,
    {
      LinearLayout,
      orientation = "vertical",
      {
        LinearLayout,
        id = "convert_container",
        orientation="vertical",
        gravity="center",
        layout_width="match_parent",
        padding="8dp",
        layout_margin="8dp",
        {
          TextView,
          text = "المبلغ القديم",
          textSize = 16,
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          EditText,
          id = "amount_edit",
          inputType = "number",
          background = "@null",
          gravity = "center",
          layout_margin="8dp",
          layout_width = "match_parent",
        },
        {
          TextView,
          text = "المبلغ الآن",
          textSize = 16,
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          EditText,
          id = "result_edit",
          background = "@null",
          gravity = "center",
          layout_margin="8dp",
          layout_width = "match_parent",
        },
        {
          TextView,
          id = "currency_text",
          text = "تقريباً بالدولار",
          textSize = 16,
          textColor = "#ffffff",
          layout_width = "match_parent",
        },
        {
          EditText,
          id = "approximately_in",
          background = "@null",
          gravity = "center",
          layout_margin="8dp",
          layout_width = "match_parent",
        },
        {
          TextView,
          id = "exchange_rate",
          textSize = 16,
          textColor = "#ffffff",
          gravity = "center",
          layout_width = "match_parent",
          layout_margin="4dp",
        },
        {
          TextView,
          id = "updated_text",
          textSize = 16,
          textColor = "#ffffff",
          gravity = "center",
          layout_width = "match_parent",
          layout_margin="4dp",
        },
        flag_container,
      },
      {
        LinearLayout,
        id = "rate_container",
        orientation="vertical",
        gravity="center",
        layout_width="match_parent",
        padding="8dp",
        layout_marginStart="8dp",
        layout_marginEnd="8dp",
        {
          Button,
          id = "rate_btn",
          text = "أسعار الصرف من موقع الليرة اليوم",
          textSize = 12,
          layout_width="match_parent",
          layout_marginBottom="8dp",
          onClick = function()          
            open_sp_today()
          end
        },
        {
          LinearLayout,
          orientation="horizontal",
          gravity="center",
          layout_width="match_parent",
          {
            Button,
            id = "gold_btn",
            text = "أسعار الذهب",
            layout_weight = 1,
            layout_marginRight="2dp",
            onClick = function()
              show_gold_prices()
            end
          },
          {
            Button,
            id = "crypto_btn",
            text = "أسعار الكريبتو",
            layout_weight = 1,
            layout_marginLeft="2dp",
            onClick = function()
              show_crypto_prices()
            end       
          },
        },
      },
    },
  },
}