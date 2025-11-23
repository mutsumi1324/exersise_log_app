require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:additional_target_calf) { FactoryBot.create(:target) }
  let(:additional_target_hip) { FactoryBot.create(:target, name: "尻") }
  let(:default_target_chest) { FactoryBot.create(:target, name: "胸") }
  let(:default_target_shoulder) { FactoryBot.create(:target, name: "肩") }
  describe "単体バリデーション" do
    describe "nameバリデーション" do
      context "nameが存在する" do
        let(:exercise) do
          FactoryBot.build(
            :exercise,
            name: "ヒップスラスト",
            target: additional_target_hip,
            created_by_user: user
          )
        end
        it "有効である" do
          expect(exercise).to be_valid
        end
      end
      context "nameが存在しない" do
        let(:exercise) do
          FactoryBot.build(
            :exercise,
            name: nil,
            target: nil,
            created_by_user: user
          )
        end
        it "無効である" do
          exercise.valid?
          expect(exercise.errors[:name]).to be_present
        end
      end
      context "nameが51文字以上である" do
        let(:to_long_name) { "a" * 51 }
        let(:exercise) do
          FactoryBot.build(
            :exercise,
            name: to_long_name,
            target: nil,
            created_by_user: user
          )
        end
        it "無効である" do
          exercise.valid?
          expect(exercise.errors[:name]).to be_present
        end
      end
    end
    describe "target_idバリデーション" do
      context "target_idが存在する" do
        let(:exercise) do
          FactoryBot.build(
            :exercise,
            name: "カーフレイズ",
            target: additional_target_calf,
            created_by_user: user
          )
        end
        it "有効である" do
          expect(exercise).to be_valid
        end
      end
      context "target_idが存在しない" do
        let(:exercise) do
          FactoryBot.build(
            :exercise,
            name: "ヒップスラスト",
            target_id: nil,
            created_by_user_id: user)
        end
        it "無効である" do
          exercise.valid?
          expect(exercise.errors[:target]).to be_present
        end
      end
    end
  end
  describe "複合バリデーション" do
    context "is_defaultがfalseだがcreated_by_user_idが存在する" do
      let(:exercise) do
        FactoryBot.build(
          :exercise, name: "ヒップスラスト",
          target: additional_target_hip,
          created_by_user: user,
          is_default: false)
      end
      it "有効である" do
        expect(exercise).to be_valid
      end
    end
    context "created_by_user_idが存在しないがis_defaultがtrueである" do
      let(:exercise) do
        FactoryBot.build(
          :exercise, name: "ヒップスラスト",
          target: additional_target_hip,
          is_default: true,
          created_by_user: nil
        )
      end
      it "有効である" do
        expect(exercise).to be_valid
      end
    end
    context "created_by_user_idもis_defaultも存在しない" do
      let(:exercise) do
        FactoryBot.build(
          :exercise, name: "ヒップスラスト",
          target: additional_target_hip,
          is_default: false,
          created_by_user: nil
        )
      end
      it "無効である" do
        exercise.valid?
        expect(exercise.errors[:base]).to be_present
      end
    end
  end
  describe "重複バリデーション" do
      context "デフォルトのレコードに対して" do
        let!(:default_exercise) do
          FactoryBot.create(
            :exercise,
            target: default_target_chest,
            name: "ベンチプレス",
            created_by_user: nil,
            is_default: true
            )
        end

        context "同じnameもtarget_idも存在しない場合" do
          let(:additional_exercise) { FactoryBot.build(:exercise) }
            it "有効である" do
              expect(additional_exercise).to be_valid
            end
        end

        context "同じnameがあるが、同じtarget_idは存在しないエクササイズ" do
          let(:additional_exercise) do FactoryBot.build(
            :exercise,
            name: "ベンチプレス",
            created_by_user: user
            )
          end
          it "有効である" do
            expect(additional_exercise).to be_valid
          end
        end

        context "同じtargetがあるが、同じnameは存在しないエクササイズ" do
          let(:additional_exercise) do FactoryBot.build(
            :exercise,
            name: "ダンベルフライ",
            target: default_target_chest
          )
          end
          it "有効である" do
            expect(additional_exercise).to be_valid
          end
        end

        context "nameとtarget_idの組み合わせがデフォルトレコードと違うエクササイズ" do
          let(:additional_exercise) do
            FactoryBot.build(
            :exercise,
            name: "ベンチプレス",
            target: default_target_shoulder,
            created_by_user: user
            )
          end
          it "有効である" do
          expect(additional_exercise).to be_valid
          end
        end
      end


      context "同一ユーザーが作成した既存レコードに対して" do
        let!(:existing_exercise) do
          FactoryBot.create(
            :exercise,
            created_by_user: user,
            target: additional_target_calf
            )
        end
        context "同じnameもtarget_idも持っていない" do
          let(:additional_exercise) do
            FactoryBot.build(
              :exercise,
              created_by_user: user,
              name: "ヒップスラスト",
              target: additional_target_hip
            )
          end
          it "有効である" do
            expect(additional_exercise).to be_valid
          end
        end
        context "同じnameとtarget_idの組み合わせが存在する" do
        let(:additional_exercise) do
          FactoryBot.build(
              :exercise,
              created_by_user: user,
              target: additional_target_calf
              )
          end
          it "無効である" do
            additional_exercise.valid?
            expect(additional_exercise.errors[:name]).to be_present
          end
        end
      end
    end

  describe "アソシエーション" do
    describe "belongs_toの関連" do
      it "targetに属している" do
        reflection = Exercise.reflect_on_association(:target)
        expect(reflection.macro).to eq(:belongs_to)
      end

      it "created_by_user(Userクラス)に属している" do
        reflection = Exercise.reflect_on_association(:created_by_user)
        expect(reflection.macro).to eq(:belongs_to)
        expect(reflection.options[:class_name]).to eq("User")
      end
    end


    describe "has_manyの関連" do
      it "workout_setモデルに対してhas_many関連を持っている" do
        reflection = Exercise.reflect_on_association(:workout_sets)
        expect(reflection.macro).to eq(:has_many)
      end
    end
    describe "dependentオプション" do
      it "exerciseを削除すると関連するworkout_setレコードも消える" do
        exercise = FactoryBot.create(:exercise, created_by_user: user)
        day = FactoryBot.create(:day, user: user)
        FactoryBot.create(
          :workout_set,
          exercise: exercise,
          day: day
        )
        expect { exercise.destroy }.to change(WorkoutSet, :count).by(-1)
      end
    end
  end
end
