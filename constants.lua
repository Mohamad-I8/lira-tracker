ICONS_DIR = dir .. "ui/icons/"
UPDATE_URL = "https://raw.githubusercontent.com/mohamad-i8/lira-tracker/main/update.lua"
URL = "https://api-v2.sp-today.com/api/v1/overview?lang=ar&city=damascus"
SP_TODAY_URL = "https://sp-today.com/"
GOLD_URL = "https://sse.sp-today.com/snapshot"
CRYPTO_URL = "https://api-v2.sp-today.com/api/v1/crypto"

CURRENCIES_DATA = {
  {icon="\u{1F1FA}\u{1F1F8}", desc="تحويل إلى الدولار الأمريكي", name="الدولار"},
  {icon="\u{1F1EA}\u{1F1FA}", desc="تحويل إلى اليورو", name="اليورو"},
  {icon="\u{1F1F9}\u{1F1F7}", desc="تحويل إلى الليرة التركية", name="الليرة التركية"},
  {icon="\u{1F1F8}\u{1F1E6}", desc="تحويل إلى الريال السعودي", name="الريال السعودي"},
  {icon="\u{1F1E6}\u{1F1EA}", desc="تحويل إلى الدرهم الإماراتي", name="الدرهم الإماراتي"},
  {icon="\u{1F1EA}\u{1F1EC}", desc="تحويل إلى الجُنَيْه المصري", name="الجُنَيْه المصري"}
}

GOLD_CARATS = {
  "24",
  "22",
  "21",
  "18",
  "14",
}

CRYPTO_CURRENCIES = {
  {
    id = "bitcoin",
    name = "Bitcoin (BTC)",
    img = ICONS_DIR .. "btc.png"
  },
  {
    id = "ethereum",
    name = "Ethereum (ETH)",
    img = ICONS_DIR .. "eth.png"
  },
  {
    id = "tether",
    name = "Tether (USDT)",
    img = ICONS_DIR .. "usdt.png"
  },
  {
    id = "binancecoin",
    name = "Binance Coin (BNB)",
    img = ICONS_DIR .. "bnb.png"
  },
  {
    id = "solana",
    name = "Solana (SOL)",
    img = ICONS_DIR .. "sol.png"
  },
  {
    id = "ripple",
    name = "Ripple (XRP)",
    img = ICONS_DIR .. "xrp.png"
  },
  {
    id = "usd-coin",
    name = "USD Coin (USDC)",
    img = ICONS_DIR .. "usdc.png"
  },
  {
    id = "cardano",
    name = "Cardano (ADA)",
    img = ICONS_DIR .. "ada.png"
  },
  {
    id = "dogecoin",
    name = "Dogecoin (DOGE)",
    img = ICONS_DIR .. "doge.png"
  },
  {
    id = "polkadot",
    name = "Polkadot (DOT)",
    img = ICONS_DIR .. "dot.png"
  },
}