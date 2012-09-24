class Admin::RolesController < Admin::ApplicationController

	helper_method :permission

	def index
		@roles = Role.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		@role = Role.new
	end

	def create
		@role = Role.new params[:role]
		if @role.save
			redirect_to :admin_roles, :notice => t("helpers.messages.edit", :model_name => Role.model_name.human)
		else
			render :new
		end
	end

	def edit
		@role = Role.find params[:id]
	end

	def update
		@role = Role.find params[:id]
    if @role.update_attributes params[:role]
      redirect_to :admin_roles, :notice => t("helpers.messages.edit", :model_name => Role.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
		@role = Role.find params[:id]
    if @role.destroy
      redirect_to :admin_roles, :notice => t("helpers.messages.destroy", :model_name => Role.model_name.human)
    else
      redirect_to :admin_roles, :alert => t("helpers.messages.error")
    end
	end

	def destroies
		if params[:role_ids].blank?
			return redirect_to :admin_roles,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Role.model_name.human)
		end
		if Role.destroy(params[:role_ids])
			redirect_to :admin_roles, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:role_ids].size,
																:model_name => Role.model_name.human)
		else
			redirect_to :admin_roles, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:role][:name].blank?
			redirect_to :admin_roles, :alert => t("helpers.messages.search_error")
			return
		else
			@roles = Role.search_name(params[:role][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end

	private
	def self.permission
  	return Role.name, "permission.controllers.admin.roles"
  end

end
