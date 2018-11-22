# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign in application' do
  before do
    create(:user)
  end

  describe 'Show login page' do
    it 'Show login with protected message' do
      visit '/'
      expect(page).to have_http_status(200)
      expect(page).to have_content('Para continuar, efetue login ou solicite acesso.')
    end
  end
end
