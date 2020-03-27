module InactiveRecord
  class Base
    class << self
      def all
        Relation.new(self)
      end

      def method_missing(method, *params)
        all.send(method, *params)
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
