module AccountComponent
  module Controls
    module Customer
      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        111
      end
    end
  end
end
