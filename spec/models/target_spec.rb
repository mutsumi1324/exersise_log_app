require 'rails_helper'

RSpec.describe Target, type: :model do
  describe "バリデーション" do
    context "DBに存在しないnameを持っている" do
      target = FactoryBot.build(:target, name: "プライオメトリクス")
      it "有効" do
        expect(target).to be_valid
      end
    end
    context "nameがない" do
      target = FactoryBot.build(:target, name: nil)
      it "規定のエラーメッセージが含まれる" do
        target.valid?
        expect(target.errors.full_messages).to include(
          "ターゲット は必須です"
        )
      end
    end
    context "DBにすでに存在するnameを持っている" do
      target = FactoryBot.build(:target, name: "胸")
      it "規定のエラーメッセージが含まれる" do
        target.valid?
        expect(target.errors.full_messages).to include(
          "ターゲット はすでに存在します"
        )
      end
    end
  end
end
