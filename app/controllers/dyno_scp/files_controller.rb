# frozen_string_literal: true

module DynoScp
  class FilesController < ::ActionController::Base
    skip_after_action :verify_authorized, raise: false

    layout false if respond_to?(:layout)

    def new; end

    def create
      file = params[:file]

      File.open(Rails.root.join("public/#{file.original_filename}"), "wb") do |f|
        f.write file.read
      end

      redirect_to new_file_path, notice: "File uploaded to public"
    end
  end
end
