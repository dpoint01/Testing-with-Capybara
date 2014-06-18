class CharactersController < ApplicationController
	def index
		@characters = Character.all
	end

	def show
		@character = Character.find(params[:id])
	end

	def new
	 	@character = Character.new
	end

	def create
		@character= Character.new(character_params)

	    if @character.save
	      flash[:notice] = "Success!"
	      redirect_to '/characters'
	    else
	      flash.now[:notice] = "Your character couldn't be saved."
	      render :new
	    end
  	end

  private

  def character_params
    params.require(:character).permit(:character_name, :actor_name, :description)
  end
end