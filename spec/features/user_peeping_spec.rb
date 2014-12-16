require 'spec_helper'

feature "User can post Peeps" do 

  before(:each) {

    User.create(:id => "1",
                :name => "Ben",
                :username => "benc93",
                :email => "ben@ben.com",
                :password => "password")

    Peep.create(:message => "Peep test 789, Peep test 789",
                :time => Time.now,
                :user_id => "1")

  }

  scenario "User must be signed-in to Peep" do 
    visit '/'
    click_link 'SIGN-IN'
    fill_in 'username', :with => "benc93"
    fill_in 'password', :with => "password"
    click_button('SIGN-IN')
    click_link 'PEEP'
    page.has_field?("message", :type => "textarea")
    fill_in("message", :with => "Test peep 1010")
    click_button('PEEP')
    expect(page).to have_content("Test peep 1010")
  end

  scenario "User is not currently signed in and tries to Peep" do 
    visit '/'
    click_link 'PEEP'
    expect(page).to have_content("User must be signed in before they can post")
  end

end
