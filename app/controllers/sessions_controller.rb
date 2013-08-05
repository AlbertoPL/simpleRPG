class SessionsController < ApplicationController
  def new
  end

  def create
  	user = login(params[:username], params[:password], params[:remember_me])
  	if user
      if user.character && user.character.enemy_id
        redirect_to fight_screen_path(user.character.enemy_id), :notice => "Logged in!"
      else 
  		  redirect_back_or_to root_url, :notice => "Logged in!"
  	  end
    else
  		flash.now.alert = "Username or password was invalid"
  		render :new
  	end
  end

  	def destroy
  		logout
  		redirect_to root_url, :notice => "Logged out"
  	end
end
