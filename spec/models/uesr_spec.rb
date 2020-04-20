require 'rails_helper'

describe '#create' do
  it "name,email,password,password_confirmationがあれば登録できること" do
    user = build(:user)
    expect(user).to be_valid
  end
end

describe '#create' do
  it "nameがない場合は登録できないこと" do
    user = build(:user, name: "")
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
end

describe '#create' do
  it "emailがない場合は登録できないこと" do
    user = build(:user, email: "")
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
end

describe '#create' do
  it "emailが重複している場合は登録できないこと" do
    user = create(:user)
    another_user = build(:user)
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end
end

describe '#create' do
  it "paswordがない場合は登録できないこと" do
    user = build(:user, password: "")
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end
end