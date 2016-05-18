require 'rails_helper'

describe UsersController do
  let(:users_controller) do
    UsersController.new
  end

  it '#show' do
    expect(users_controller.show).to eq('Exception in RSpec')
  end
end
