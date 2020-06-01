require 'rails_helper'

describe TasksController do
  # describe 'GET #new' do
  #   it "new.html.erbに遷移するか" do
  #     get :new
  #     expect(response).to render_template :new
  #   end
  # end

  describe 'GET #edit' do
    it "get.html.erbに遷移するか" do
      task = create(:task)
      get :edit, params: { id: task }
      expect(response).to render_template :edit
    end
    it "@taskに正しい値が入っているか " do
      task = create(:task)
      get :edit, params: { id: task }
      expect(assigns(:task)).to eq task
    end
  end
end