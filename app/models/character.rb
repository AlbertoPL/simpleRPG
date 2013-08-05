class Character < ActiveRecord::Base

	EXP_TABLE = [0, 1000, 2000, 4000, 7000, 10000, 13000, 16000, 20000, 24000,
		28000, 32000, 36000, 40000, 45000, 50000, 55000, 60000, 65000, 71000,
		77000, 83000, 89000, 96000, 103000, 110000, 117000, 124000, 132000, 140000]

	def heal(health)
		amounthealed = 0
		if (health + hp) > maxhp
			amounthealed = maxhp - hp
			hp = maxhp
		else 
			increment(:hp, health)
			amounthealed = health
		end
		save
		amounthealed
	end

	def takedamage(damage)
		decrement!(:hp, damage)
	end

	def gaingold(gold)
		increment!(:gold, gold)
	end

	def losegold(gold)
		decrement!(:gold, gold)
	end

	def gainexp(xp)
		increment(:exp, xp)
		leveled = false
		if exp >= EXP_TABLE[level]
			leveled = levelup
		end
		save
		leveled
	end

	def addmaxhealth(health)
		increment!(:maxhp, health)
	end

	def addmindamage
		increment!(:mindamage, 1)
	end

	def addmaxdamage
		increment!(:maxdamage, 1)
	end

private

	def levelup
		increment(:hp, hpperlevel)
		addmaxhealth(hpperlevel)
		increment(:level, 1)
		true
	end
end
