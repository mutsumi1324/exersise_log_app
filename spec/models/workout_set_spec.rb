require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  describe "バリデーション" do
    context "有効な重量・レップ・メモがある" do
      workout_set = FactoryBot.build(:workout_set)
      it "有効" do
        expect(workout_set).to be_valid
      end
    end
    context "無効な重量" do
      workout_set = FactoryBot.build(:workout_set, weight: 45.255)
      workout_set.valid?
      it "規定のエラーメッセージが含まれる" do
        expect(workout_set.errors.full_messages).to include(
          "重量 は3桁までの整数と小数第2位までで入力してください"
        )
      end
    end
    context "無効なレップ数" do
      workout_set = FactoryBot.build(:workout_set, reps: 1000)
      workout_set.valid?
      it "規定のエラーメッセージが含まれる" do
        expect(workout_set.errors.full_messages).to include(
          "回数 は1以上100以下の数字で入力してください"
        )
      end
    end
  end
end
