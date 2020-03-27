module InactiveRecord
  class Relation
    def initialize(klass, params = {})
      @klass = klass
      @params = params
      @params[:where] ||= []
      @params[:order] ||= []
      @params[:limit] ||= nil
    end

    # return a new relation, including the new `where` conditions
    def where(conditions)
      Relation.new(@klass, @params.merge(where: @params[:where] + conditions.to_a))
    end

    # return a new relation, including the new `order` criteria
    def order(*criteria)
      Relation.new(@klass, @params.merge(order: @params[:order] + criteria))
    end

    # return a new relation, including the new `limit` number
    def limit(number)
      Relation.new(@klass, @params.merge(limit: number))
    end

    def first
      @first ||= limit(1).to_a.first
    end

    def to_a
      @to_a ||= execute_select('*')
        .map { |attributes| @klass.new(attributes) }
    end

    def count
      @count ||= execute_select('count(*)')
        .first['count'].to_i
    end

    def map(&block)
      to_a.map(&block)
    end

    def inspect
      "[#{to_a.map(&:inspect).join(', ')}]"
    end

    private

    def execute_select(selection)
      clauses = []
      clauses << "select #{selection}"
      clauses << "from #{table_name}"
      if @params[:where].any?
        clauses << "where #{@params[:where].map { |name, value| "#{name} = '#{value}'" }.join(' and ')}"
      end
      if @params[:order].any?
        clauses << "order by #{@params[:order].join(', ')}"
      end
      if @params[:limit]
        clauses << "limit #{@params[:limit]}"
      end
      InactiveRecord.execute_sql("#{clauses.join(' ')};")
    end

    def table_name
      @klass.name.underscore.pluralize
    end
  end
end
