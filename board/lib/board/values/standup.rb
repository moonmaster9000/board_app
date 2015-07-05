require "board/values/expose_hash_keys_as_readers"

module Board
  module Values
    class Standup < ExposeHashKeysAsReaders
      def items
        @hash
      end
    end
  end
end
