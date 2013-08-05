class HealScreensController < ApplicationController

	def update
		amount_to_heal = 0
		if params[:healval].to_i == current_user.character.maxhp
			amount_to_heal = current_user.character.maxhp - current_user.character.hp
		else
			amount_to_heal = params[:healval].to_i
		end

		if current_user.character.hp == current_user.character.maxhp
			redirect_to heal_screen_path, :notice => "You're already at full health!"
		elsif current_user.character.gold >= amount_to_heal
			amounthealed = current_user.character.heal(amount_to_heal)
			current_user.character.losegold(amounthealed)
			redirect_to heal_screen_path, :notice => "Healed #{amounthealed} hp!"
		else
			redirect_to heal_screen_path, :notice => "You don't have enough gold to heal that much!"
		end
	end

	def show
	end
end