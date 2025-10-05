require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe "バリデーション" do
    context "同じnameとtarget_idとcreated_by_user_idの組み合わせが存在しない" do
      context "デフォルトのレコードの中に同じnameとtarget_idの組み合わせが存在しない" do
        let(:exercise) { FactoryBot.build(:exercise) }
        it "有効である" do
          expect(exercise).to be_valid
        end
      end
    end
  end
end
