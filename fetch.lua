function fetch_crypto(check_time)
  if check_time == nil then
    check_time = true
  end
  cache = load_cache() or {}
  
  if check_time and cache.crypto and cache_valid(cache.crypto.time) then
    refresh_ui("crypto", cache.crypto.data)
    return
  end
  
  Http.get(CRYPTO_URL, function(status, data)
    if status == 200 then
      decoded = cjson.decode(data)
      api_list = decoded.data
      prices = {}
      for i = 1, #CRYPTO_CURRENCIES do
        for _, item in ipairs(api_list) do
          if item.id == CRYPTO_CURRENCIES[i].id then
            table.insert(prices, {
              name = CRYPTO_CURRENCIES[i].name,
              usd = item.price_usd,
              syp = item.price_syp,
              rank = tonumber(item.rank) or 999
            })
            break
          end
        end
      end
     
      table.sort(prices, function(a, b)
        return a.rank < b.rank
      end)
      cache.crypto = {time = os.time(), data = prices}
      save_cache(cache)
      refresh_ui("crypto", prices)
    elseif cache.crypto then
      refresh_ui("crypto", cache.crypto.data)
    end
  end)
end

function fetch_gold(check_time)
  if check_time == nil then
    check_time = true
  end
  cache = load_cache() or {}
 
  if check_time and cache.gold and cache_valid(cache.gold.time) then
    refresh_ui("gold", cache.gold.data)
    return
  end

  Http.get(GOLD_URL, function(status, data)
    if status == 200 then
      prices = {}
      gold = cjson.decode(data).data.gold
      for i = 1, #GOLD_CARATS do
        key = GOLD_CARATS[i] .. "k:damascus"
        table.insert(prices, {
          carat = GOLD_CARATS[i],
          buy = gold[key].buy,
          sell = gold[key].sell
        })
      end
      cache.gold = {time = os.time(), data = prices}
      save_cache(cache)
      refresh_ui("gold", prices)
    elseif cache.gold then
      refresh_ui("gold", cache.gold.data)
    end
  end)
end

function fetch_currencies(check_time)
  if check_time == nil then
    check_time = true
  end
  cache = load_cache() or {}

  if check_time and cache.currencies and cache_valid(cache.currencies.time) then
    refresh_ui("currencies", cache.currencies.data)
    return
  end

  Http.get(URL, function(status, data)
    if status == 200 then
      currencies_list = {}
      rates = cjson.decode(data).data.rates
      for i = 1, #rates do
        rate = rates[i].cities["damascus"]
        table.insert(currencies_list, {rate.buy, rate.sell, rates[i].updated_at})
      end
      cache.currencies = {time = os.time(), data = currencies_list}
      save_cache(cache)
      refresh_ui("currencies", currencies_list)
    elseif cache.currencies then
      refresh_ui("currencies", cache.currencies.data)
    end
  end)
end
