class CharactersController < ApplicationController
  def new
  	@character = Character.new
  end

  def create
  	@character = Character.new(params[:character])
  	if @character.save
      current_user.update_attribute(:character, @character)
  		redirect_to :back, :notice => "Character created!"
  	else
  		render :new
  	end
  end
end
