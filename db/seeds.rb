newuser = User.new({ :email => '2891@qq.com', :password => '123123', :password_confirmation => '123123'})
newuser.admin = true
newuser.save