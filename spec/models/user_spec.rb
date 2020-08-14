require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do
    it 'nameとpasswordどちらも値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end

    it 'nameが空だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'nameが10字でOK' do
      @user.name = 'a' * 10
      expect(@user.valid?).to eq(true)
    end

    it 'nameが11字でNG' do
      @user.name = 'a' * 11
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが7字でNG' do
      @user.password = 'a' * 7
      expect(@user.valid?).to eq(false)
    end
  end
end
