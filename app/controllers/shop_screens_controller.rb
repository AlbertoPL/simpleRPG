class ShopScreensController < ApplicationController

	def update
		if params[:addmaxhp]
			if current_user.character.gold >= 15
				current_user.character.addmaxhealth(params[:addmaxhp].to_i)
				current_user.character.losegold(15)
				redirect_to shop_screen_path, :notice => "Bought 5 max health!"
			else
				redirect_to shop_screen_path, :notice => "Not enough gold to do that!"
			end
		elsif params[:addmindamage]
			if current_user.character.gold >= 15
				if current_user.character.mindamage < current_user.character.maxdamage
					current_user.character.addmindamage
					current_user.character.losegold(15)
					redirect_to shop_screen_path, :notice => "Increased min damage by 1!"
				else
					redirect_to shop_screen_path, :notice => "Can't increase min damage! Try increasing max damage first."
				end
			else
				redirect_to shop_screen_path, :notice => "Not enough gold to do that!"			
			end
		elsif params[:addmaxdamage] 
			if current_user.character.gold >= 10
				current_user.character.addmaxdamage
				current_user.character.losegold(10)
				redirect_to shop_screen_path, :notice => "Increased max damage by 1!"
			else
				redirect_to shop_screen_path, :notice => "Not enough gold to do that!"			
			end
		end
	end

	def show
	end

end
