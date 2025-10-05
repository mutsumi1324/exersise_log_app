require 'rails_helper'

RSpec.describe UserMetric, type: :model do
  it "ファクトリーが有効" do
    user_metric = FactoryBot.build(:user_metric)
    expect(user_metric).to be_valid
  end
  describe "バリデーション" do
    context "身長・体重が正しいフォーマットで記入されている" do
      user_metric = FactoryBot.build(:user_metric)
      it "有効" do
      expect(user_metric).to be_valid
      end
    end
    context "身長が少数になっている" do
      user_metric = FactoryBot.build(
        :user_metric,
        height: 170.5
        )
      it "規定のエラーメッセージが含まれる" do
      user_metric.valid?
      expect(user_metric.errors.full_messages).to include(
        "身長 は1〜299までの整数で入力してください"
      )
      end
    end
    context "体重が少数第３位までで書かれている" do
      user_metric = FactoryBot.build(
          :user_metric,
          body_weight: 65.555
        )
      it "規定のエラーメッセージが含まれる" do
        user_metric.valid?
        expect(user_metric.errors.full_messages).to include(
          "体重 は0.01〜999.99までの整数または小数第2位までで入力してください"
        )
      end
    end
  end
end
