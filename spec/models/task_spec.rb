require 'rails_helper'

describe '#create' do
  let(:user) { FactoryBot.create(:user) }
  let(:tag) { FactoryBot.create(:tag) }
  let(:task) { FactoryBot.create(:task, user_id: user.id, tag_id: tag.id) }
  context "ログイン状態の場合" do
  
    it "date,starttime,finishtime,title,description,done,tag_id,user_idがあれば登録できること" do
      expect(task).to be_valid
    end

    it "dateがなければ登録できないこと" do
      expect(user.errors[:date]).to include("を入力してください")
    end

  end
end

