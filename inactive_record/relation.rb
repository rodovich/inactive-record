module InactiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
    end

    def to_a
      InactiveRecord.execute_sql("select * from #{table_name};").map do |attributes|
        @klass.new(attributes)
      end
    end

    def count
      InactiveRecord.execute_sql("select count(*) from #{table_name};")
        .first['count'].to_i
    end

    def to_s
      "[#{to_a.join(', ')}]"
    end

    private

    def table_name
      @klass.name.underscore.pluralize
    end
  end
end
