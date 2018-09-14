class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role.name == AppConstants::ADMIN

      admin user

    elsif user.role.name == AppConstants::CASHIER

      cashier user

    end
  end

  def admin(user)
    can :manage, :all
  end

  def cashier(user)
    can       [:read], :all
    can       [:update], User, user.id
    can       [:create, :sale_order], Order
    can       [:create], OrderProduct
    cannot    [:destroy, :update, :create], Product
    can       [:read], PurchaseOrder 
    cannot    [:manage], PurchaseOrderProduct

  end

end
