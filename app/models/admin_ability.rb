class AdminAbility
  include CanCan::Ability

  def initialize(user)
    alias_action :destroies, :to => :destroy

    if user.admin?
      can :manage, :all
    else
      user.permissions.each do |permission|
        if permission.subject_id.nil?
          if permission.subject_class == "all"
            can permission.action.to_sym, permission.subject_class.to_sym
          else
            case permission.action
            when "setting"
              can permission.action.to_sym, permission.subject_class.constantize, :id => user.id
            else
              can permission.action.to_sym, permission.subject_class.constantize
            end
          end
        else
          can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
        end
      end
    end
  end
end
