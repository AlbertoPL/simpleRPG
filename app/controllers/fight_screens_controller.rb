class FightScreensController < ApplicationController

	def new
		@enemy = create_enemy
		@enemy.update_attribute(:maxhp, rand(current_user.character.level * 5) + 10)
		@enemy.update_attribute(:hp, @enemy.maxhp)

		@enemy.update_attribute(:mindamage, current_user.character.level)
		@enemy.update_attribute(:maxdamage, @enemy.maxdamage + current_user.character.level)		
		
		current_user.character.update_attribute(:enemy_id, @enemy.id)
		redirect_to fight_screen_path(@enemy.id), :notice => "Fight started!"
	end

	def show
		@enemy = get_enemy(params[:id])
	end

	def update

		if params[:id].to_i == current_user.character.enemy_id
			enemymove = rand(3)
			enemy = get_enemy(params[:id])
			if enemymove == 0 #punch

				damage = case params[:move]

				when "Punch" then (rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage).ceil
				when "Kick" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *1.5).ceil
				when "Chop" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *0.5).ceil
				else
					0
				end
			elsif enemymove == 1 #kick
				damage = case params[:move]

				when "Punch" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *0.5).ceil
				when "Kick" then (rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage).ceil
				when "Chop" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *1.5).ceil
				else
					0
				end
			elsif enemymove == 2 #chop
				damage = case params[:move]

				when "Punch" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *1.5).ceil
				when "Kick" then ((rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage) *0.5).ceil
				when "Chop" then (rand(current_user.character.maxdamage - current_user.character.mindamage) + current_user.character.mindamage).ceil
				else
					0
				end
			end

			enemydamage = (rand(enemy.maxdamage - enemy.mindamage) + enemy.mindamage).ceil
			update_enemy(enemy, damage)
			current_user.character.takedamage(enemydamage)
			if current_user.character.hp <= 0
				current_user.character.destroy
				current_user.character = nil
				redirect_to welcome_screens_path, :notice => "Your character has perished!"
			elsif enemy.hp <= 0
				enemy.destroy
				current_user.character.enemy_id = nil
				expearned = rand(101) + (100 * current_user.character.level) 
				goldearned = rand(11) + 10
				leveled = current_user.character.gainexp(expearned)
				current_user.character.gaingold(goldearned)
				if leveled
					redirect_to welcome_screens_path, :notice => "You defeated your opponent! You earned #{expearned} experience and gained #{goldearned} gold. You gained a level! Max health increased to #{current_user.character.maxhp}."
				else
					redirect_to welcome_screens_path, :notice => "You defeated your opponent! You earned #{expearned} experience and gained #{goldearned} gold."
				end
			else
				redirect_to fight_screen_path(params[:id]), :notice => "You dealt #{damage} damage. They dealt #{enemydamage} damage."
			end
		else
			redirect_to welcome_screens_path, :notice => "Error fighting enemy"
		end
	end

	helper_method :create_enemy
	helper_method :update_enemy
	helper_method :get_enemy

	private
  		def create_enemy
    		Character.create
  		end

  		def get_enemy(id)
  			Character.find(id)
  		end

  		def update_enemy(enemy, damage)
  			enemy.takedamage(damage)
		end
end
