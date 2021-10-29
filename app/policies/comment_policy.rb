class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user_is_owner_of_record?
  end

  def user_is_owner_of_record?
    @user == @record.user
  end
end
