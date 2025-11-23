require 'rails_helper'

RSpec.describe User, type: :model do
  describe "単体バリデーション" do
    describe "nameバリデーション" do
      context "有効なnameが存在する" do
        let(:user) do
          FactoryBot.build(
          :user,)
        end
        it "有効である" do
          expect(user).to be_valid
        end
      end
      context "nameが存在しない" do
        let(:user) do FactoryBot.build(
          :user,
          name: nil)
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:name]).to be_present
        end
      end
      context "nameの内容が長すぎる場合" do
        let(:too_long_name) { "あ" * 30 }
        let(:user) do FactoryBot.build(
          :user,
          name: too_long_name
        )
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:name]).to be_present
        end
      end
      context "nameの内容が短すぎる場合" do
        let(:user) do FactoryBot.build(
          :user,
          name: "あ")
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:name]).to be_present
        end
      end
    end
    describe "emailバリデーション" do
      context "有効なemailが存在する" do
        let(:user) do FactoryBot.create(
          :user,
          email: "tarou@example.com"
        )
        end
        it "有効である" do
          expect(user).to be_valid
        end
      end
      context "emailが存在しない" do
        let(:user) do FactoryBot.build(
          :user,
          email: nil)
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:email]).to be_present
        end
      end
      context "存在しないメールアドレス" do
        let(:user) do FactoryBot.build(
          :user,
          email: "tarouexample.com"
          )
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:email]).to be_present
        end
      end
    end
    describe "passwordバリデーション" do
      context "有効なパスワードが存在する" do
        let(:user) do FactoryBot.create(
          :user,
          password: "Password@1",
          password_confirmation: "Password@1"
        )
        end
        it "有効である" do
          expect(user).to be_valid
        end
      end
      context "パスワードが存在しない" do
        let(:user) do FactoryBot.build(
          :user,
          password: nil
          )
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:password]).to be_present
        end
      end
      context "パスワードと確認用パスワードが不一致" do
        let(:user) do FactoryBot.build(
          :user,
          password: "Password@1",
          password_confirmation: "Password@2"
        )
        end
        it "無効である" do
          user.valid?
          expect(user.errors[:base]).to be_present
        end
      end
      context "無効なパスワード" do
        invalid_password = {
          "短すぎる" => "Pass@",
          "長すぎる" => "Password@1Password@1",
          "大文字がない" => "password@1",
          "小文字がない" => "PASSWORD@1",
          "数字がない" => "Password@@",
          "記号がない" => "Password11"
        }
        invalid_password.each do |label, pw|
          it "#{label}場合は無効である" do
            user = build(
              :user,
              password: pw,
              password_confirmation: pw
              )
          user.valid?
          expect(user.errors[:password]).to be_present
          end
        end
      end
    end
  end
  describe "アソシエーション" do
    describe "has_manyの関連" do
      it "dayに対してhas_many関連を持っている" do
        reflection = User.reflect_on_association(:days)
        expect(reflection.macro).to eq :has_many
      end
      it "exerciseのcreated_by_user_idに対してhas_manyの関係を持っている" do
        reflection = User.reflect_on_association(:exercises)
        expect(reflection.macro).to eq :has_many
        expect(reflection.options[:foreign_key]).to eq :created_by_user_id
      end
      it "user_metricsに対してhas_manyの関係を持っている" do
        reflection = User.reflect_on_association(:user_metrics)
        expect(reflection.macro).to eq :has_many
      end
      it "targetのcreated_by_user_idに対してhas_manyの関係を持っている" do
        reflection = User.reflect_on_association(:target)
        expect(reflection.macro).to eq :has_many
        expect(reflection.options[:foreign_key]).to eq :created_by_user_id
      end
    end
    describe "dependentオプション" do
      let(:user) { create(:user) }
      it "userを削除すると関連するdayレコードも消える" do
        FactoryBot.create(:day, user: user)
        expect { user.destroy }.to change(Day, :count).by(-1)
      end
      it "userを削除すると関連するexerciseレコードも消える" do
        FactoryBot.create(:exercise, created_by_user: user)
        expect { user.destroy }.to change(Exercise, :count).by(-1)
      end
      it "userを削除すると関連するuser_metricレコードも消える" do
        FactoryBot.create(:user_metric, user: user)
        expect { user.destroy }.to change(UserMetric, :count).by(-1)
      end
      it "userを削除すると関連するtargetレコードも消える" do
        FactoryBot.create(:user_metric, user: user)
      end
    end
  end
end
