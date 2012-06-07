Tower.Route.draw ->
  @resources "posts"
  @resources "users"
  # @match "(/*path)", to: "application#index"
  @match "/", to: "application#welcome"