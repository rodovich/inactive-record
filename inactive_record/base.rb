module InactiveRecord
  class Base
    class << self
      def all
        Relation.new(self)
      end

      def method_missing(method, *params)
        all.send(method, *params)
      end

      def belongs_to(relation_name)
        define_method(relation_name) do
          instance_variable_get("@#{relation_name}") || begin
            other_class = Kernel.const_get(relation_name.to_s.camelize)
            instance_variable_set "@#{relation_name}",
              other_class.where(id: send(other_class.foreign_key_name)).first
          end
        end
      end

      def has_many(relation_name)
        klass = self
        define_method(relation_name) do
          instance_variable_get("@#{relation_name}") || begin
            other_class = Kernel.const_get(relation_name.to_s.singularize.camelize)
            instance_variable_set "@#{relation_name}",
              other_class.where(klass.foreign_key_name => id)
          end
        end
      end

      def foreign_key_name
        "#{name.underscore}_id"
      end
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def method_missing(method)
      @attributes[method.to_s]
    end

    def inspect
      "<#{self.class.name} #{@attributes.map { |name, value| "#{name}=#{value.inspect}"}.join(' ')}>"
    end
  end
end
