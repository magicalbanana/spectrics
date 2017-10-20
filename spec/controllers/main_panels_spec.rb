require 'rails_helper'

describe MainPanelsController do

  it 'should display the main panel' do
    get :index

    expect(response).to have_http_status(:success)
  end
end