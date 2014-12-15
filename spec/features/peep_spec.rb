require 'spec_helper'
require 'orderly'

feature "User visits homepage" do 

  before(:each) {

    User.create(:id => "1",
                :name => "Ben",
                :username => "benc93",
                :email => "ben@ben.com",
                :password => "password")

    Peep.create(:message => "Peep test 123, Peep test 123",
                :time => Time.now,
                :user_id => "1")

  }

  scenario "expect to see peeps" do 
    visit '/'
    expect(page).to have_content("Peep test 123")
  end

  scenario "newest peeps first" do 
    visit '/'
    expect(page).to have_content("Peep test 123")
    Peep.create(:message => "Ron Paul 456",
                :time => Time.now + 60,
                :user_id => "1")
    visit '/'
    expect("456").to appear_before("123")
  end

end