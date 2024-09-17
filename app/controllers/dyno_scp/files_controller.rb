# frozen_string_literal: true

module DynoScp
  class FilesController < ::ActionController::Base
    skip_after_action :verify_authorized, raise: false
    before_action :ensure_public_folder_exists

    layout false if respond_to?(:layout)

    def index
      @files = fetch_public_files
    end

    def new; end

    def create
      file = params[:file]

      if file.nil?
        redirect_to new_file_path, alert: "No file selected"
        return
      end

      save_path = Rails.root.join("#{::DynoScp.folder_path}/#{file.original_filename}")
      filename = resolve_name_collision(file.original_filename) if File.exist?(save_path)

      File.open(Rails.root.join("#{::DynoScp.folder_path}/#{filename}"), "wb") do |f|
        f.write file.read
      end

      redirect_to new_file_path, notice: "File uploaded to public"
    end

    def destroy
      file_path = Rails.root.join("#{::DynoScp.folder_path}/#{params[:file_name]}")
      if File.exist?(file_path)
        File.delete(file_path)
        redirect_to files_path, notice: "#{params[:file_name]} deleted"
      else
        redirect_to files_path, notice: "File not found"
      end
    end

    private

    def ensure_public_folder_exists
      FileUtils.mkdir_p("#{::DynoScp.folder_path}") unless Dir.exist?(::DynoScp.folder_path)
    end

    def fetch_public_files
      files = Dir.glob("#{::DynoScp.folder_path}/**/*").select { |file| File.file?(file) }

      files.map do |file|
        {
          name: File.basename(file),
          relative_path: "/#{::DynoScp.folder}/#{File.basename(file)}",
          path: Rails.root.join(file).to_s,
          size: File.size(file),
          created_at: File.ctime(file).to_fs(:long)
        }
      end
    end

    def resolve_name_collision(filename)
      basename = File.basename(filename, ".*")
      extension = File.extname(filename)
      counter = 1

      # Loop until we find a file name that doesn't exist
      while File.exist?(Rails.root.join("#{::DynoScp.folder_path}/#{basename}(#{counter})#{extension}"))
        counter += 1
      end

      "#{basename}(#{counter})#{extension}"
    end
  end
end
