class Character < ActiveRecord::Base
	validates :character_name, presence: true
	validates :actor_name, presence: true

	validates :character_name, uniqueness: {scope: :actor_name}  
end