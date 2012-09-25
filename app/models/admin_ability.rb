class AdminAbility
  include CanCan::Ability

  def initialize(user)
    alias_action :destroies, :to => :destroy

    user.permissions.each do |permission|
      if permission.subject_id.nil?
        Clogger.success "can #{permission.action.to_sym}, #{permission.subject_class.constantize}"
        can permission.action.to_sym, permission.subject_class.constantize
      else
        can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
      end
    end

    if user.admin?
      can :manage, :all
    end
    
  end

end
