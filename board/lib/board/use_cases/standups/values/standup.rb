require "board/use_cases/private/values/expose_hash_keys_as_readers"

module Board
  module Values
    class Standup < ExposeHashKeysAsReaders
      def items
        @hash
      end

      def available_items
        @hash.reject do |_, value|
          value.empty?
        end
      end
    end
  end
end
