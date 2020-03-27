module InactiveRecord
  class Relation
    def initialize(klass, params = {})
      @klass = klass
      @params = params
      @params[:where] ||= []
    end

    # return a new relation, including the new `where` conditions
    def where(conditions)
      Relation.new(@klass, @params.merge(where: @params[:where] + conditions.to_a))
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
      clauses = []
      clauses << "select #{selection}"
      clauses << "from #{table_name}"
      if @params[:where].any?
        clauses << "where #{@params[:where].map { |name, value| "#{name} = #{value}" }.join(' and ')}"
      end
      InactiveRecord.execute_sql("#{clauses.join(' ')};")
    end

    def table_name
      @klass.name.underscore.pluralize
    end
  end
end
