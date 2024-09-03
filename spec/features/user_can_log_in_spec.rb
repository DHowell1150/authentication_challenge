require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: 'Jane', email: 'user1@example.com', password: "test123", password_confirmation: "test123")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :name, with: user.name
    fill_in :email, with: user.email
    fill_in :password, with: "test123"
    fill_in :password_confirmation, with: "test123"

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "can log in with bad credentials" do
    user = User.create(name: 'Jane', email: 'user1@example.com', password: "test123", password_confirmation: "test123")

    visit login_path

    fill_in :name, with: "Jane"
    fill_in :email, with: "user1@example.com"
    fill_in :password, with: "tes"
    fill_in :password_confirmation, with: "tes12"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad")
  end
end
# at the part in lesson just below "We did it!" ...bouncer