require 'rails_helper'

RSpec.describe "static_pages/about", type: :view do
  scenario 'should have the title about' do
    visit about_path
    expect(page).to have_title full_title('About')
  end
end
