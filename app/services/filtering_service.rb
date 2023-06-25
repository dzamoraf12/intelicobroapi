class FilteringService  
  def initialize(scope, filters, associations = [])
    @scope = scope
    @scope = scope.includes(*associations) if associations.any?
    @filters = filters
    @errors = []
  end

  def filter
    validate_dates if @filters[:created_between]
     
    return @scope if @errors.any?

    @filters.each do |key, value|
      if value.present?
        @scope = @scope.public_send(key, value)
      end
    end

    @scope
  end
  
  private
  def validate_dates
    start_date, end_date = @filters[:created_between].begin, @filters[:created_between].end

    start_date ||= Date.new(1970,1,1)
    end_date ||= Time.now

    if start_date > end_date
      @errors << "Start date must be before end date"
      @filters.delete(:created_between)
    else
      @filters[:created_between] = start_date..end_date
    end
  end
end
