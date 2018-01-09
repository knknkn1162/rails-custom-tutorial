require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  scenario 'should have the content Sample App' do
    visit root_path
    expect(page).to have_title full_title('Home')
  end

  scenario 'should have the proper link in home' do
    visit root_path
    # in the logo and the left of the header
    expect(page).to have_link href: root_path, count: 2
    # in the header
    expect(page).to have_link href: help_path
    # in the footer
    expect(page).to have_link href: about_path
    # in the footer
    expect(page).to have_link href: contact_path
  end
end
