require 'rails_helper'

RSpec.describe UserMetric, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe "単体バリデーション" do
    describe "身長バリデーション" do
      context "身長が正しいフォーマットで記入されている" do
        let(:user_metric) do FactoryBot.build(:user_metric,
          height: 170)
        end
        it "有効である" do
        expect(user_metric).to be_valid
        end
      end
      context "身長が300以上である" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          height: 300)
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:height]).to be_present
        end
      end
      context "身長が100以下である" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          height: 100)
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:height]).to be_present
        end
      end
      context "身長が少数になっている" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          height: 101.5
          )
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:height]).to be_present
        end
      end
    end
    describe "体重バリデーション" do
      context "体重が正しいフォーマットで記載されている" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          body_weight: 64.55
          )
        end
        it "有効である" do
          expect(user_metric).to be_valid
        end
      end
      context "体重が400以上である" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          body_weight: 400
        )
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:body_weight]).to be_present
        end
      end
      context "体重が20以下である" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          body_weight: 400
        )
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:body_weight]).to be_present
        end
      end
      context "体重が少数第３位までで書かれている" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          body_weight: 65.455
        )
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:body_weight]).to be_present
        end
      end
    end
    describe "user_idバリデーション" do
      context "user_idが存在する" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          user: user
        )
        end
        it "有効である" do
          expect(user_metric).to be_valid
        end
      end
      context "user_idが存在しない" do
        let(:user_metric) do FactoryBot.build(
          :user_metric,
          user: nil
        )
        end
        it "無効である" do
          user_metric.valid?
          expect(user_metric.errors[:user]).to be_present
        end
      end
    end
  end
  describe "コールバック" do
    describe "before_validation :normalize_blank_value" do
      it "空文字の項目を nil に変換する" do
        user_metric = FactoryBot.build(
        :user_metric,
        height: " ",
        body_weight: " "
      )
      user_metric.valid?
      expect(user_metric.height).to eq nil
      expect(user_metric.body_weight).to eq nil
      end
    end
  end
  describe "アソシエーション" do
    describe "belongs_toの関連" do
      it "userに対してbelongs_toの関連を持っている" do
        reflection = UserMetric.reflect_on_association(:user)
        expect(reflection.macro).to eq :belongs_to
      end
    end
  end
end
