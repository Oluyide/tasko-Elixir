# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config


# General application configuration
config :api_example,
  ecto_repos: [ApiExample.Repo]

config :api_example, ApiExample.Repo,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

config :sms_blitz, twilio: {"AC07f30ef7369725d9a5c134685c60f182", "71db5a1408c136c4b882a87ee01115c2"}

config :fcmex,
  server_key: "AAAAjnUoEvY:APA91bGTIoH3OtPGQcOIdhMRutKnnhIhBThmsdQSWxee9uioGheMl5pPzrx2xyrBd6gKLFmdwV-fNMtlKLHSXny-K00dT0OyKcGU3v303WloHuICovn6mHLiHcIrnDmf8fB5tDkFnF4L"


# Configures the endpoint
config :api_example, ApiExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aK+3ohyh72+E+C58nA9+rN2RVvGvUVWpQndMf1eW0r7ZorMriVncIXJPOXl/zYVX",
  render_errors: [view: ApiExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ApiExample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian config
config :api_example, ApiExample.Guardian,
       issuer: "api_example",
       secret_key: "GATqZ1db01WATWzN7MlirN24PYUoCoAptEPa8NoWtafTGhaZOr0EunJHJ8DmdlTf"

config :api_example, ecto_repos: [ApiExample.Repo]
config :api_example, ApiExample.Repo,
types: ApiExample.PostgrexTypes
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :api_example, gmaps_api_key: "AIzaSyDE_IT2q3gaXcOYCgkXjJhovCxN0hr2xaQ"

import_config "#{Mix.env}.exs"
