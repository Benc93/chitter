require 'spec_helper'

feature "User signs in" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "benc93",
                :email => "ben@ben.com",
                :password => "password")
  }

  scenario 'and has the correct details' do
    visit '/'
    expect(page).not_to have_content("it's time to Chit...")
    click_link('SIGN-IN')
    fill_in 'username', :with => "benc93"
    fill_in 'password', :with => "password"
    click_button('SIGN-IN')
    expect(page).to have_content("it's time to Chit...")
  end

   scenario 'and does not have the correct credentials' do
    visit '/'
    expect(page).not_to have_content("it's time to Chit...")
    click_link('SIGN-IN')
    fill_in 'username', :with => "benc93"
    fill_in 'password', :with => "possword"
    click_button('SIGN-IN')
    expect(page).to have_content("Incorrect email or password")
  end

end
