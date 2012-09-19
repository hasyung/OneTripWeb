class Admin::UsersController < Admin::ApplicationController

	def index
		 @users = User.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		 @user = User.new
	end

	def create
		 @user = User.new params[:user]
		 if @user.save
		  	redirect_to :admin_users, :notice => t("helpers.messages.new", :model_name => User.model_name.human)
	 	else
			  render :new
		 end
	end

	def edit
		 @user = User.find params[:id]
	end

	def update
		 @user = User.find params[:id]
     if @user.update_attributes params[:user]
       redirect_to :admin_users, :notice => t("helpers.messages.edit", :model_name => User.model_name.human)
     else
       render :action => "edit"
     end
	end

	def destroy
		 @user = User.find params[:id]
     if @user.destroy
       redirect_to :admin_users, :notice => t("helpers.messages.destroy", :model_name => User.model_name.human)
     else
       redirect_to :admin_users, :alert => t("helpers.messages.error")
     end
	end

	def destroy_multiple
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
end