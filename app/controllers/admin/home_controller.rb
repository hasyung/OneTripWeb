class Admin::HomeController < Admin::ApplicationController
	
	skip_authorization_check

	helper_method :permission

	def index
		@newest_places = Place.newest(3).created_desc
    @newest_minorities = Minority.newest(3).created_desc
		@newest_articles = Article.newest(5).created_desc
		@newest_audios = Audio.newest(5).created_desc
		@newest_videos = Video.newest(5).created_desc
    @newest_images = Image.newest(5).created_desc
		@newest_infos = Info.newest(5).created_desc
		@newest_users = User.newest(5).created_desc
		@newest_roles = Role.newest(5).created_desc
	end
	
end
