module Nestful
  module Formats
    class MultipartFormat < Format
      def extension
        "multipart_form"
      end
    end
  end
end