module InactiveRecord
  class Relation
    def initialize(klass)
      @klass = klass
    end

    def to_a
      execute_select('*').map do |attributes|
        @klass.new(attributes)
      end
    end

    def count
      execute_select('count(*)')
        .first['count'].to_i
    end

    def to_s
      "[#{to_a.join(', ')}]"
    end

    private

    def execute_select(selection)
      select_clause = "select #{selection}"
      from_clause = "from #{table_name}"
      InactiveRecord.execute_sql("#{select_clause} #{from_clause};")
    end

    def table_name
      @klass.name.underscore.pluralize
    end
  end
end
