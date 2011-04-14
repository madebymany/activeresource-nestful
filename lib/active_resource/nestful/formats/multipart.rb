require 'action_dispatch/http/upload'

module Nestful
  module Formats
    class MultipartFormat < Format
      def extension
        "multipart_form"
      end

      protected
        def looks_like_a_file_with_actiondispatch_uploads?(value)
          looks_like_a_file_without_actiondispatch_uploads?(value) || value.is_a?(ActionDispatch::Http::UploadedFile)
        end
        alias_method_chain :looks_like_a_file?, :actiondispatch_uploads
    end
  end
end