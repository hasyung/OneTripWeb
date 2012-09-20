class PublisherRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :write, Article
  end

  module Cached
    def permit_rules
    end
  end

  module NonCached
    def permit_rules
    end
  end
end
