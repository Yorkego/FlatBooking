class FlatPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    @user.vendor
  end

  def update?
    return true if user.present? && user == flat.user
  end

  def destroy?
    return true if user.present? && user == flat.user
  end

  def secret?
    @user.admin
  end

  private

  def flat
    record
  end
end
