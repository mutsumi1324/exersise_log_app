require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ファクトリーボット" do
    it "デフォルトのファクトリーボットが有効" do
      user =  FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end
  describe "バリデーション" do
      context "有効な名前、メール、パスワードが揃っている" do
        let(:user) {
          FactoryBot.build(
          :user,
          name: "山田太郎",
          email: "tarou@example.com",
          password: "Password@1",
          password_confirmation: "Password@1")
        }
        it "有効である" do
        expect(user).to be_valid
        end
      end


      context "無効な名前" do
        user = FactoryBot.build(
          :user,
          name: "寿限無寿限無五項の擦り切れ海砂利水魚の水行松雲来松風来松食う寝るところに住むところ"
        )
        it "規定のエラーメッセージが含まれる" do
          user.valid?
          expect(user.errors.full_messages).to include(
            "名前 は2〜20文字のひらがな・カタカナ・漢字・アルファベットいずれかで入力してください"
          )
        end
      end
      context "無効なメールアドレス" do
        user = FactoryBot.build(
        :user,
        email: "tarouexample.com"
        )
        it "規定のエラーメッセージが含まれる" do
          user.valid?
          expect(user.errors.full_messages).to include(
            "メールアドレス は存在するアドレスのフォーマットで入力してください"
          )
        end
      end
      context "無効なパスワード" do
        user = FactoryBot.build(
          :user,
          password: "passwor",
          password_confirmation: "passwor",
        )
        it "規定のエラーメッセージが含まれる" do
          user.valid?
          expect(user.errors.full_messages).to include(
            "パスワード は半角英字（大文字・小文字を含む）・半角数字・記号を含む8〜15文字で入力してください",
           )
        end
      end
      context "パスワードと確認用パスワードが不一致" do
        user = FactoryBot.build(
          :user,
          password: "Password@1",
          password_confirmation: "Password@2"
        )
        it "規定のエラーメッセージが含まれる" do
          user.valid?
          expect(user.errors.full_messages).to include "確認用パスワードが一致しません"
      end
      end
  end
end
