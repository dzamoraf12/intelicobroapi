class ProspectDashboardService  
  def initialize(scope)
    @scope = scope
    @result = []
    @translation_scope = "app.prospects.dashboard_metrics"
  end

  def generate_metrics
    pending
    verified
    accepted
    rejected

    @result
  end

  private

  def pending
    @result << {
      text: I18n.t("#{@translation_scope}.pending"),
      value: @scope.pending.count,
      redirect_to: "appPage"
    }
  end

  def verified
    @result << {
      text: I18n.t("#{@translation_scope}.verified"),
      value: @scope.verified.count,
      redirect_to: "appPage"
    }
  end

  def accepted
    @result << {
      text: I18n.t("#{@translation_scope}.accepted"),
      value: @scope.accepted.count,
      redirect_to: "appPage"
    }
  end

  def rejected
    @result << {
      text: I18n.t("#{@translation_scope}.rejected"),
      value: @scope.rejected.count,
      redirect_to: "appPage"
    }
  end
end