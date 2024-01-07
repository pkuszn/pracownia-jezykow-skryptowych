local config = require("lapis.config")

config("development", {
    port = 8085,
    sqlite3 = {
      database = "../config/shop-js.db",
    },
  })