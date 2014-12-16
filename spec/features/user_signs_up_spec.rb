require 'spec_helper'

feature "User can sign up" do 

  before(:each) {
    User.create(:name => "Ben",
                :username => "benc93",
                :email => "ben@ben.com",
                :password => "password")
    }

  scenario "with unique login details" do 
    visit '/'
    click_link('REGISTRATION')
    fill_in 'email', :with => 'ron@paul.com'
    fill_in 'name', :with => 'Ron'
    fill_in 'username', :with => 'ronpaul2016'
    fill_in 'password', :with => 'atlas'
    click_button 'SIGN-UP'
    expect(page).to have_content("May all you peeps be inspirational")   
  end

  scenario "username already taken" do 
    visit '/'
    expect(User.count).to be 1
    click_link('REGISTRATION')
    fill_in 'username', :with => "benc93"
    click_button 'SIGN-UP'
    expect(User.count).to be 1 
    expect(page).to have_content("Username has already been taken.")
  end

  scenario "email already taken" do 
    visit '/'
    expect(User.count).to be 1
    click_link('REGISTRATION')
    fill_in 'email', :with => "ben@ben.com"
    click_button 'SIGN-UP'
    expect(User.count).to be 1 
    expect(page).to have_content("Email address has already been taken.")
  end

end