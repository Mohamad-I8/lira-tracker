-- Import necessary modules
require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.Color"
import "android.graphics.drawable.GradientDrawable"
import "android.graphics.Typeface"
import "android.util.TypedValue"
import "android.text.*"
import "java.time.ZonedDateTime"
import "java.time.format.DateTimeFormatter"
import "java.util.Locale"
import "android.webkit.WebView"
import "android.webkit.WebViewClient"
import "cjson"
import "android.content.DialogInterface"

-- Define project directory
dir = package.searchpath("main",package.path):match("(.*)main.lua")

-- Execute other project files
dofile(dir .. "constants.lua")
dofile(dir .. "utils.lua")
dofile(dir .. "fetch.lua")
dofile(dir .. "ui/layout/flag.lua")
dofile(dir .. "ui/layout/web.lua")
dofile(dir .. "ui/layout/carat.lua")
dofile(dir .. "ui/layout/gold.lua")
dofile(dir .. "ui/layout/cryptocurrency.lua")
dofile(dir .. "ui/layout/crypto.lua")
dofile(dir .. "ui/layout/main.lua")

-- Global variables to store currency data
currencies = {}
current_currency_index = 1

-- Core conversion function
function calc_conversion(amount_text)
  if #currencies == 0 then return end
  amount = tonumber(amount_text)
  if amount == nil then
    result_edit.setText("")
    approximately_in.setText("")
    return
  end
  res = amount / 100
  result_edit.setText(tostring(math.floor(res)))
  selected_rate = currencies[current_currency_index]
  res_usd = amount / selected_rate[1]
  approximately_in.setText(string.format("%.2f", res_usd))
end

-- Open web view for SP Today website
function open_sp_today()
  web_dlg = LuaDialog(service)
  web_dlg.setView(loadlayout(web_layout))
  web_dlg.setCancelable(false)
  web_dlg.show()
  web.setWebViewClient(WebViewClient())
  settings = web.getSettings()
  settings.setJavaScriptEnabled(true)
  settings.setDomStorageEnabled(true)
  settings.setAllowFileAccess(true)
  web.loadUrl(SP_TODAY_URL)
  web_dlg.setOnKeyListener(DialogInterface.OnKeyListener{
    onKey = function(dialog, keyCode, event)
      if keyCode == KeyEvent.KEYCODE_BACK and event.getAction() == KeyEvent.ACTION_UP then
        if web.canGoBack() then
          web.goBack()
          return true
        end
        return true
      end
      return false
    end
  })
end

-- UI for displaying gold prices
function show_gold_prices()
  gold_prices = {}
  fetch_gold()
  gold_dlg = LuaDialog()
  .setView(loadlayout(gold_layout))
  .show()
  gold_container.setBackground(makeRoundedCorners(Color.parseColor("#1E1E1E")))
  for i, carat in ipairs(GOLD_CARATS) do
    view = loadlayout(create_carat_view(i, GOLD_CARATS[i]))
    _G["tv_" .. i].setBackground(makeRoundedCorners(Color.parseColor("#FDB200"), 100))
    gold_container.addView(view)
  end
end

-- UI for displaying cryptocurrency prices
function show_crypto_prices()
  crypto_dlg = LuaDialog()
  .setView(loadlayout(crypto_layout))
  .show()
  crypto_container.setBackground(makeRoundedCorners(Color.parseColor("#1E1E1E")))
  for i, currency in ipairs(CRYPTO_CURRENCIES) do
    view = loadlayout(create_crypto_view(i, currency.name, currency.img))
    crypto_container.addView(view)
  end
  fetch_crypto(true)
  if crypto_img_6 then
    crypto_img_6.setColorFilter(0xffffffff)
  end
end

-- Entry point
function main()
  -- Generate currency flags dynamically
  for i, item in ipairs(CURRENCIES_DATA) do
    table.insert(flag_container, {
      TextView,
      id = "flag_icon_" .. i,
      text = item.icon,
      contentDescription = item.desc,
      textColor = "#ffffff",
      padding = "4dp",
      onClick = function()
      end
    })
  end

 -- Create and display main dialog
  fetch_currencies()
  dlg = LuaDialog()
  .setView(loadlayout(main_layout))
  .show()
 
  -- Make rounded corner widgets
  convert_container.setBackground(makeRoundedCorners(Color.parseColor("#1E1E1E")))
  amount_edit.setBackground(makeRoundedCorners(Color.parseColor("#3d3d3d")))
  result_edit.setBackground(makeRoundedCorners(Color.parseColor("#3d3d3d")))
  approximately_in.setBackground(makeRoundedCorners(Color.parseColor("#3d3d3d")))
  rate_container.setBackground(makeRoundedCorners(Color.parseColor("#1E1E1E")))
  rate_btn.setBackground(makeRoundedCorners(Color.parseColor("#05423A")))
  gold_btn.setBackground(makeRoundedCorners(Color.parseColor("#D3A610")))
  crypto_btn.setBackground(makeRoundedCorners(Color.parseColor("#088DFF")))

 -- Handle conversion logic on text change
  amount_edit.addTextChangedListener(luajava.createProxy("android.text.TextWatcher", {
    beforeTextChanged = function(s, start, count, after) end,
    onTextChanged = function(s, start, before, count)
      txt = tostring(s)
      if txt == "" then
        result_edit.setText("")
        approximately_in.setText("")
        return
      end
      calc_conversion(txt)
    end,
    afterTextChanged = function(s) end
  }))
end

-- Run the project
main()
