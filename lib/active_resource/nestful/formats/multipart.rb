require 'action_dispatch/http/upload'

module Nestful
  module Formats
    class MultipartFormat < Format
      cattr_accessor :decode_format
      def extension
        "multipart_form"
      end

      def decode_with_format_choice(body)
        if self.class.decode_format.present?
          formatter = ::Nestful::Formats[self.class.decode_format]
          if formatter.nil?
            decode_without_format_choice(body)
          else
            formatter.new.decode(body)
          end
        else
          decode_without_format_choice(body)
        end
      end
      alias_method_chain :decode, :format_choice

      protected
        def encode_value_with_nested_serializable_hashing(key, value)
          if value.respond_to?(:serializable_hash)
            to_multipart(value.serializable_hash, key)
          else
            encode_value_without_nested_serializable_hashing(key, value)
          end
        end
        alias_method_chain :encode_value, :serializable_hashing

        def looks_like_a_file_with_actiondispatch_uploads?(value)
          looks_like_a_file_without_actiondispatch_uploads?(value) || value.is_a?(ActionDispatch::Http::UploadedFile)
        end
        alias_method_chain :looks_like_a_file?, :actiondispatch_uploads
    end
  end
end
