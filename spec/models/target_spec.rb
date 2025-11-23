require 'rails_helper'

RSpec.describe Target, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:anothor_user)  { FactoryBot.create(:user) }
  describe "単体バリデーション" do
    describe "nameバリデーション" do
      context "nameがある" do
        let(:target) do FactoryBot.build(:target,
          name: "ふくらはぎ",
          created_by_user: user
          )
        end
        it "有効である" do
          target.valid?
          expect(target).to be_valid
        end
      end
      context "nameがない" do
        let(:target) do FactoryBot.build(
          :target,
          name: nil,
          created_by_user: user
          )
        end
        it "無効である" do
          target.valid?
          expect(target.errors[:name]).to be_present
        end
      end
      context "nameが26文字以上" do
        let(:to_long_name) { "a"* 26 }
        let(:target) do FactoryBot.build(
          :target,
          name: to_long_name,
          created_by_user: user
          )
        end
        it "無効である" do
          target.valid?
          expect(target.errors[:name]).to be_present
        end
      end
    end
  end
  describe "複合バリデーション" do
    describe "defaultとcreated_by_userの整合性" do
      context "created_by_userが存在せずdefaultがtrue" do
        let(:target) do FactoryBot.build(:target,
          created_by_user: nil,
          is_default: true)
        end
        it "有効である" do
          expect(target).to be_valid
        end
      end
      context "created_by_userが存在しており、defultがfalse" do
        let(:target) do FactoryBot.build(:target,
          created_by_user: user,
          is_default: false
        )
        end
        it "有効である" do
          expect(target).to be_valid
        end
      end
      context "created_by_userが存在しdefaultがtrue" do
        let(:target) do FactoryBot.build(:target,
          created_by_user: user,
          is_default: true)
        end
        it "無効である" do
          expect(target).to_not be_valid
        end
      end
      context "created_by_userが存在せずdefaultがfalse" do
        let(:target) do FactoryBot.build(:target,
          created_by_user: nil,
          is_default: false
          )
        end
        it "無効である" do
          expect(target).to_not be_valid
        end
      end
    end
  end
  describe "uniqueバリデーション" do
      context "デフォルトのレコードとの比較" do
        let!(:default_target) do FactoryBot.create(:target,
            name: "胸",
            is_default: true,
            created_by_user_id: nil
            )
          end
        context "同じnameが存在しない" do
          let(:additional_target) do FactoryBot.build(
            :target,
            name: "ふくらはぎ",
            created_by_user: user
            )
          end
          it "有効である" do
            expect(additional_target).to be_valid
          end
        end
        context "同じnameが存在する" do
           let(:additional_target) do FactoryBot.build(:target,
            name: "胸",
            )
          end
          it "無効である" do
            expect(additional_target).to_not be_valid
          end
        end
      end

      context "既存レコードとの比較" do
        let!(:existing_target) do FactoryBot.create(:target,
          name: "ふくらはぎ",
          created_by_user: user
          )
        end
        context "同じcreated_user_idを持っている" do
          context "同じnameが存在しない" do
            let(:additional_target) do FactoryBot.build(:target,
              name: "尻",
              created_by_user: user
              )
            end
            it "有効である" do
              expect(additional_target).to be_valid
            end
          end
          context "同じnameが存在する" do
            let(:additional_target) do FactoryBot.build(:target,
              name: "ふくらはぎ",
              created_by_user: user
            )
            end
            it "無効である" do
              expect(additional_target).to_not be_valid
            end
          end
        end
        context "同じcreated_user_idを持っていない" do
          context "同じnameが存在する" do
            let(:additional_target) do FactoryBot.build(
              :target,
              name: "ふくらはぎ",
              created_by_user: anothor_user
              )
            end
            it "有効である" do
              expect(additional_target).to be_valid
            end
          end
        end
      end
    end
  describe "アソシエーション" do
    describe "belongs_toの関連" do
      it "userに対してbelongs_toの関連を持っている" do
        reflection = Target.reflect_on_association(:created_by_user)
        expect(reflection.macro).to eq :belongs_to
        expect(reflection.options[:class_name]).to eq("User")
      end
    end
    describe "has_manyの関連" do
      it "exerciseに対してhas_manyの関連を持っている" do
        reflection = Target.reflect_on_association(:exercises)
        expect(reflection.macro).to eq :has_many
      end
    end
    describe "dependentオプション" do
      it "targetを削除すると関連するexerciseレコードも削除される" do
        target = FactoryBot.create(:target, created_by_user: user)
        FactoryBot.create(
          :exercise,
          created_by_user: user,
          target: target
          )
        expect { target.destroy }.to change(Exercise, :count).by(-1)
      end
    end
  end
end
