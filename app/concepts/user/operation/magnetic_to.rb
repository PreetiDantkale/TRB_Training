module User::Operation
  class MagneticTo < Trailblazer::Operation

    step :log_file
    step :file_type_image?, Output(:success) => Track(:image_upload), Output(:failure) => Track(:file_check)
    step :file_type_video?, Output(:success) => Track(:video_upload), magnetic_to: :file_check
    step :upload_video, magnetic_to: :video_upload

    step :process_image, magnetic_to: :image_upload, Output(:success) => Track(:image_upload)
    step :upload_image, magnetic_to: :image_upload

    step :set_response
    fail :set_error

    def log_file(ctx, **)
      p "In Log File method...."
    end

    def file_type_image?(ctx, **)
      false
    end

    def file_type_video?(ctx, **)
      true
    end

    def upload_video(ctx, **)
      p "Uploading Video..."
    end

    def process_image(ctx, **)
      p "1. Processing Image..."
    end

    def upload_image(ctx, **)
      p "2. Uploading Image..."
    end

    def set_response(ctx, **)
      p "All set.."
    end

    def set_error(ctx, **)
      p "Error occured...."
    end
  end
end
