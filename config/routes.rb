# frozen_string_literal: true

DynoScp::Engine.routes.draw do
  # Only allow access if the engine was mounted in the /dyno_scp namespace
  constraints(->(req) { req.fullpath.split("/").reject(&:blank?).first == "dyno_scp" }) do
    resources :files, only: %i(new create)
    root "files#new"
  end
end
