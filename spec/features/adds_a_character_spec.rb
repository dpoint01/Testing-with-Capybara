require 'rails_helper'


feature 'user adds a new character', %Q{
	As a site visitor
	I want to add my favorite TV show characters
	So that other people can enjoy their crazy antics

	Acceptance Criteria:
	* I can access a form to add a character on a TV show's page
	* I must specify the character's name and the actor's name
	* I can optionally provide a description
	* If I do not provide the required information, I receive an error message
	* If the character already exists in the database, I receive an error message
} do

 	scenario 'user adds a new character' do
	    attrs = {
	      character_name: 'Jon Snow',
	      actor_name: "Jon Snow Real",
	      description: "You Know Nothing"
	    }

	    character = Character.new(attrs)

	    visit '/characters/new'
	    fill_in 'Character name', with: character.character_name
	    fill_in 'Actor name', with: character.actor_name
	    fill_in 'Description', with: character.description
	    click_on 'Submit'

	    expect(page).to have_content 'Success'
	    expect(page).to have_content character.character_name
	    expect(page).to have_content character.actor_name

    end

  scenario 'without required attributes' do
    visit '/characters/new'
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add a character that is already in the database' do
    attrs = {
     character_name: 'Jon Snow',
	 actor_name: "Jon Snow Real"
    }

    character = Character.create(attrs)

    visit '/characters/new'
    fill_in 'Character name', with: character.character_name
    fill_in 'Actor name', with: character.actor_name
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end

end