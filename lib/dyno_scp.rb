# frozen_string_literal: true

require "dyno_scp/version"
require "dyno_scp/engine"

module DynoScp
  FOLDER = "dyno_scp"

  class << self
    def folder
      FOLDER
    end

    def folder_path
      "public/#{FOLDER}"
    end
  end

  private

  def dyno_scp_config
    Rails.application.config_for("dyno_scp")
  end
end
