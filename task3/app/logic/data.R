box::use(
  config,
  dplyr,
  pool[dbPool, poolClose],
  rhino[log],
  RSQLite[dbReadTable, SQLite],
)

create_pool <- function() {
  db <- config$get("db")
  driver <- switch(db$driver,
    sqlite = SQLite(),
    stop()
  )
  args <- c(list(driver), db$args)
  log$info("Creating DB pool")
  do.call(dbPool, args)
}

close_pool <- function(pool) {
  if (pool$valid) {
    log$info("Closing DB pool")
    poolClose(pool)
  }
}

db_pool <- create_pool()
reg.finalizer(db_pool, close_pool, onexit = TRUE)
.on_unload <- function(ns) {
  close_pool(db_pool)
}

#' @export
fetch_favorites <- function() {
  dbReadTable(db_pool, "favorites")
}

#' @export
filter_favorites <- function(favorites, min_age) {
  favorites |>
    dplyr$filter(age >= min_age)
}