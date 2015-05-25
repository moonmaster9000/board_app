module Board
  module Values
    class ExposeHashKeysAsReaders
      def initialize(hash)
        @hash = hash
      end

      def method_missing(method_name, *args, &block)
        if @hash.has_key?(method_name)
          @hash[method_name]
        else
          super
        end
      end
    end
  end
end
