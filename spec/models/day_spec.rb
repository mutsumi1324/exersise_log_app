require 'rails_helper'

RSpec.describe Day, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe "単体バリデーション" do
    describe "occurred_onバリデーション" do
      context "存在する日付である" do
        let(:day) { FactoryBot.build(:day, occurred_on: Date.today) }
        it "有効である" do
        expect(day).to be_valid
        end
      end
      context "存在しない日付である" do
        let(:day) { FactoryBot.build(:day, occurred_on: "2025-10-32") }
        it "無効である" do
          day.valid?
          expect(day.errors[:occurred_on]).to be_present
        end
      end
      context "日付が存在しない" do
        let(:day) { FactoryBot.build(:day, occurred_on: nil) }
        it "無効である" do
          day.valid?
          expect(day.errors[:occurred_on]).to be_present
        end
      end
    end
    describe "user_idバリデーション" do
      context "user_idが存在する" do
        let(:day) do FactoryBot.build(
          :day,
          user: user
        )
        end
        it "有効である" do
          expect(day).to be_valid
        end
      end
      context "user_idが存在しない" do
        let(:day) do FactoryBot.build(
          :day,
          user: nil
          )
        end
        it "無効である" do
          day.valid?
          expect(day.errors[:user]).to be_present
        end
      end
    end
  end
  describe "アソシエーション" do
    context "belongs_toの関連" do
      it "userに属している" do
        reflection = Day.reflect_on_association(:user)
        expect(reflection.macro).to eq(:belongs_to)
      end
    end
    context "has_manyの関連" do
      it "workout_setに対してhas_manyの関連がある" do
        reflection = Day.reflect_on_association(:workout_sets)
        expect(reflection.macro).to eq(:has_many)
      end
    end
    context "dependentオプション" do
      it "dayを削除すると関連するworkout_setも削除される" do
        user = FactoryBot.create(
          :user
        )
        day = FactoryBot.create(
          :day,
          user: user)
        exercise = FactoryBot.create(
          :exercise,
          created_by_user: user
        )
        FactoryBot.create(
          :workout_set,
          day: day,
          exercise: exercise
          )
        expect { day.destroy }.to change(Day, :count).by(-1)
      end
    end
  end
end
