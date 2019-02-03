defmodule ApiExample.Guardian.AuthPipeline do
    use Guardian.Plug.Pipeline, otp_app: :MyApi,
    module: ApiExample.Guardian,
    error_handler: ApiExample.AuthErrorHandler
  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
  end