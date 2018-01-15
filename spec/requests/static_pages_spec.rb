require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /index" do
    it "works! (now write some real specs)" do
      get root_path
      expect(response).to render_template(:home)
    end
  end
end
