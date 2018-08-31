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

  def edit?
    update?
  end

  def update?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end

  def secret?
    @user.admin
  end
end
