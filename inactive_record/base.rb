module InactiveRecord
  class Base
    class << self
      def all
        Relation.new(self)
      end

      def count
        all.count
      end
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def to_s
      "<#{self.class.name} #{@attributes.map { |name, value| "#{name}=#{value.inspect}"}.join(' ')}>"
    end
  end
end
