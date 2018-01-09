require 'rails_helper'

RSpec.describe "static_pages/help.html.erb", type: :view do
  scenario 'should have the title help' do
    visit help_path
    expect(page).to have_title full_title('Help')
  end
end
