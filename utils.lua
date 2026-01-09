-- Data caching logic
CACHE_FILE = service.getLuaDir() .. "/cache.json"
ONE_HOUR = 3600

function load_cache()
  file = io.open(CACHE_FILE, "r")
  if not file then
    return nil
  end
  content = file:read("*a")
  file:close()
  return cjson.decode(content)
end

function save_cache(tbl)
  file = io.open(CACHE_FILE, "w")
  if not file then
    return
  end
  file:write(cjson.encode(tbl))
  file:close()
end

function cache_valid(t)
  if not t then
    return false
  end
  return (os.time() - t) <= ONE_HOUR
end

-- UI styling and formatting utils
function dp(x)
  return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, x, service.getResources().getDisplayMetrics())
end

function makeRoundedCorners(color, radius)
  gd = GradientDrawable()
  gd.setShape(GradientDrawable.RECTANGLE)
  gd.setColor(color)
  if radius then
    gd.setCornerRadius(radius)
  else
    gd.setCornerRadius(dp(15))
  end
  return gd
end

function format_price(value)
  num = tonumber(value) or 0
  if num >= 1 then
    return tostring(tointeger(math.floor(num)))
  else
    return string.format("%.2f", num)
  end
end

function parseDate(date_str)
  parsedDate = ZonedDateTime.parse(date_str)
  formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm a", Locale("ar"))
  return parsedDate.format(formatter)
end

-- Core UI refresh and click logic
function refresh_ui(type, data)
  service.handler.post(function()
    if type == "crypto" then
      for i = 1, #data do
        if _G["crypto_name_" .. i] then 
          _G["crypto_name_" .. i].setText(data[i].name) 
        end
        if _G["price_usd_" .. i] then 
          _G["price_usd_" .. i].setText("السعر بالدولار: " .. format_price(data[i].usd)) 
        end
        if _G["price_syp_" .. i] then 
          _G["price_syp_" .. i].setText("بالليرة: " .. format_price(data[i].syp)) 
        end
      end
    
    elseif type == "gold" then
      for i = 1, #data do
        buy_val = format_price(data[i].buy)
        sell_val = format_price(data[i].sell)
        if _G["name_" .. i] then 
          _G["name_" .. i].setText("عيار " .. data[i].carat) 
        end
        if _G["buy_" .. i] then 
          _G["buy_" .. i].setText("شراء: " .. buy_val) 
        end
        if _G["sell_" .. i] then 
          _G["sell_" .. i].setText("مبيع: " .. sell_val) 
        end
      end

    elseif type == "currencies" then
      currencies = data
      if #data > 0 then
        if exchange_rate then 
          exchange_rate.setText("سعر الصرف: " .. format_price(data[1][1])) 
        end
        if updated_text then 
          updated_text.setText("آخر تحديث: " .. parseDate(data[1][3])) 
        end
      end
      
      for i = 1, #CURRENCIES_DATA do
        flag_view = _G["flag_icon_" .. i]
        if flag_view and data[i] then
          flag_view.setOnClickListener(View.OnClickListener{
            onClick = function(v)
              current_currency_index = i
              buy_rate = data[i][1]
              update_time = data[i][3]
              
              currency_text.setText("تقريباً ب" .. CURRENCIES_DATA[i].name)
              exchange_rate.setText("سعر الصرف: " .. format_price(buy_rate))
              updated_text.setText("آخر تحديث: " .. parseDate(update_time))
              
              current_input = amount_edit.getText().toString()
              if current_input ~= "" then
                calc_conversion(current_input)
              end
            end
          })
        end
      end
    end
  end)
end
