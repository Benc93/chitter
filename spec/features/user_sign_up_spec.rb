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
    
  end

end