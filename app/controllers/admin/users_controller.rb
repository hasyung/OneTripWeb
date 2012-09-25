class Admin::UsersController < Admin::ApplicationController

	load_and_authorize_resource
	
	helper_method :permission

	def index
		@users = @user.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
	end

	def create
		if @user.save
	  	redirect_to :admin_users, :notice => t("helpers.messages.new", :model_name => User.model_name.human)
	 	else
		  render :new
		end
	end

	def edit
	end

	def update
		params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

		if @user.update_attributes(params[:user])
      redirect_to :admin_users, :notice => t("helpers.messages.edit", :model_name => User.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
    if @user.destroy
      redirect_to :admin_users, :notice => t("helpers.messages.destroy", :model_name => User.model_name.human)
    else
      redirect_to :admin_users, :alert => t("helpers.messages.error")
    end
	end

	def destroies
		if params[:user_ids].blank?
		  return redirect_to :admin_users,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => User.model_name.human)
		end
		if User.destroy(params[:user_ids])
		  redirect_to :admin_users, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:user_ids].size,
																:model_name => User.model_name.human)
		else
		  redirect_to :admin_users, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:user][:email].blank?
			redirect_to :admin_users, :alert => t("helpers.messages.search_error")
			return
		else
			@users = @users.search_name(params[:user][:email]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end

	def permission
		@permissions = @user.permissions
	end

	private
	def self.permission
  	return User.name, "permission.controllers.admin.users"
  end
end