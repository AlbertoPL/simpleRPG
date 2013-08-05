class MyTestController < ApplicationController
before_filter :checklogin, :only => :show

	def index
		@users = User.all
	end

	def show
		
	end

#	def hi
#		"Hi"
#	end
#	helper_method :hi

def checklogin
	#check session validity
	redirect_to "/my_test"
end

end
