namespace :utils do
	desc "Setup Actions to Database"
	task :setup_actions => :environment do
		# 清空数据库只限用于第一次或者是调试模式下
 #clean_permission_db

		setup_actions_controllers_db
	end

	def setup_actions_controllers_db
	  write_permission("all", "manage", "permission.controllers.all", "permission.actions.all", true)
	  
	  controllers = Dir.new("#{Rails.root}/app/controllers/admin").entries
	  controllers.each do |controller|
	    if controller =~ /_controller/
	      c_instance = File.join("admin", controller).camelize.gsub(".rb", "").constantize.new
	    end
	  end

	  Admin::ApplicationController.subclasses.each do |controller|
	  	puts controller
	    if controller.respond_to?(:permission)
	      clazz, description = controller.permission
	      write_permission(clazz, "manage", description, "permission.actions.all")
	      controller.action_methods.each do |action|
	        if action.to_s.index("_callback").nil?
	          action_desc, cancan_action = eval_cancan_action(clazz, action)
	          write_permission(clazz, cancan_action, description, action_desc)
	        end
	      end
	    end
	  end
	end

	def write_permission(class_name, cancan_action, name, description, force_id_1 = false)
		puts "#{class_name}---#{cancan_action}"
	  permission  = Permission.find(:first, :conditions => ["subject_class = ? and action = ?", class_name, cancan_action]) 
	  if not permission
	    permission = Permission.new
	    permission.id = 1 unless not force_id_1
	    permission.subject_class = class_name
	    permission.action = cancan_action
	    permission.name = name
	    permission.description = description
	    permission.save
	  else
	    permission.name = name
	    permission.description = description
	    permission.save
	  end
	end

	def eval_cancan_action(clazz, action)
	  case action.to_s
	  when "index", "show", "search"
    if %w(Setting).include?(clazz)
      cancan_action = "update"
      action_desc = "permission.actions.update"
    else
      cancan_action = "read"
      action_desc = "permission.actions.read"
    end
	 when "create", "new"
	    cancan_action = "create"
	    action_desc = "permission.actions.create"
	  when "edit", "update"
	    cancan_action = "update"
	    action_desc = "permission.actions.update"
	  when "delete", "destroy", "destroies", "deletes"
	    cancan_action = "destroy"
	    action_desc = "permission.actions.destroy"
	  else
	    cancan_action = action.to_s
	    action_desc = "permission.actions.#{cancan_action}"
	  end
	  return action_desc, cancan_action
	end

	def clean_permission_db
		Permission.delete_all
	end

end