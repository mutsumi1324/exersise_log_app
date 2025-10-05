require 'rails_helper'

RSpec.describe Day, type: :model do
 it "ファクトリーが有効" do
  day = FactoryBot.build(:day)
  expect(day).to be_valid
 end
 describe "バリデーション" do
  context "存在する日付である" do
    day = FactoryBot.build(:day, occurred_on: Date.today)
    it "有効である" do
    expect(day).to be_valid
    end
  end
  context "存在しない日付である" do
    day = FactoryBot.build(:day, occurred_on: "2025-10-32")
    it "規定のエラーメッセージが含まれる" do
    day.valid?
    expect(day.errors.full_messages).to include(
      "日付 は存在する日付を入力してください"
    )
    end
  end
 end
end
