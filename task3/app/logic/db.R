box::use(
  config,
  pool[dbPool, poolClose],
  rhino[log],
  RSQLite[SQLite],
)

create_pool <- function(conf) {
  driver <- switch(conf$db_driver,
    sqlite = SQLite(),
    stop()
  )
  args <- c(list(driver), conf$db_args)

  # Step 5:
  log$info("Opening DB pool")

  do.call(dbPool, args)
}

close_pool <- function(pool) {
  if (pool$valid) {
    log$info("Closing DB pool")
    poolClose(pool)
  }
}

# Step 4:
#' @export
pool <- create_pool(conf = config$get())

# Step 6:
reg.finalizer(pool, close_pool, onexit = TRUE) # Better option: Use R6 class to wrap `pool` from Step 4

.on_unload <- function(ns) {
  close_pool(pool)
}
