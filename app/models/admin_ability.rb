class AdminAbility
  include CanCan::Ability

  def initialize(user)
    alias_action :destroies, :to => :destroy

    user.permissions.each do |permission|
      if permission.subject_id.nil?
        if permission.subject_class == "all"
          can permission.action.to_sym, permission.subject_class.to_sym
        else
          can permission.action.to_sym, permission.subject_class.constantize
        end
        case permission.action
        when "setting"
          can permission.action.to_sym, permission.subject_class.constantize, :id => user.id
        end
      else
        can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
      end
    end

    if user.admin?
      can :manage, :all
    end
    
  end

end
