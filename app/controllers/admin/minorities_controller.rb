class Admin::MinoritiesController < Admin::ApplicationController
  load_and_authorize_resource

	helper_method :permission

	def index
		@minorities = @minorities.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def show
		@areas = @minority.areas.includes(:area_category).page(params[:page]).per(8).order_asc.created_desc
	end

	def new
		
	end

	def create
    @minority.transaction do
      if @minority.save
        AreaCategory.minorities.each do |area_category|
          @area = Area.new :area_category_id => area_category.id, :order => area_category.order
          @minority.areas << @area
        end
        redirect_to admin_minority_url(@minority), :notice => t("helpers.messages.new", :model_name => Minority.model_name.human)
      else
        render :new
      end
    end
  end

	def edit
		
	end

	def update
    if @minority.update_attributes params[:minority]
    	redirect_to admin_minority_url(@minority), :notice => t("helpers.messages.edit", :model_name => Minority.model_name.human)
    else
    	render :action => "edit"
    end
	end

	def destroy
    if @minority.destroy
      redirect_to :admin_minorities, :notice => t("helpers.messages.destroy", :model_name => Minority.model_name.human)
    else
      redirect_to :admin_minorities, :alert => t("helpers.messages.error")
    end
	end
  
  def destroies
		if params[:minority_ids].blank?
			return redirect_to :admin_minorities,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Minority.model_name.human)
		end
		if Minority.destroy(params[:minority_ids])
			redirect_to :admin_minorities, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:minority_ids].size,
																:model_name => Minority.model_name.human)
		else
			redirect_to :admin_minorities, :alert => t("helpers.messages.notices.error")
		end
	end
  
 def search
		if params[:minority][:name].blank?
		  redirect_to :admin_minorities, :alert => t("helpers.messages.search_error")
		  return
	  else
		  @minorities = @minorities.search_name(params[:minority][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
   render :index
	end

	def publish
		@minority.status = params[:status].to_s.to_sym
		if @minority.save
			if @minority.publish?
				redirect_to :admin_minorities, :notice => t("helpers.messages.publish_minority")
			else
				redirect_to :admin_minorities, :notice => t("helpers.messages.draft_minority")
			end
		else
			redirect_to :admin_minorities, :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Minority.name, "permission.controllers.admin.minorities"
  end
end
