class ApplicationPolicy
  attr_reader :admin, :report

  def initialize(admin, report)
    raise Pundit::NotAuthorizedError, "must be logged in" unless admin
    @admin = admin
    @report = report
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :admin, :scope

    def initialize(admin, scope)
      raise Pundit::NotAuthorizedError, "must be logged in" unless admin
      @admin = admin
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
