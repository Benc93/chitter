require 'spec_helper'

feature "User can sign out" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "benc93",
                :email => "ben@ben.com",
                :password => "password")
  }

  scenario 'whilst user is already signed in' do
    visit '/'
    click_link('SIGN-IN')
    fill_in 'username', :with => "benc93"
    fill_in 'password', :with => "password"
    click_button('SIGN-IN')
    click_link('SIGN-OUT')
    expect(page).to have_content("Goodbye! Please come again")
  end

  scenario 'whilst a user hasn\'t signed in' do
    visit '/'
    click_link('SIGN-OUT')
    expect(page).to have_content("You're not yet signed in")
  end

end