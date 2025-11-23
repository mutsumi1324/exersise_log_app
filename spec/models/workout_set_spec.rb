require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:day) { FactoryBot.create(:day, user: user) }
  let(:anothor_day) do FactoryBot.create(
      :day,
      user: user,
      occurred_on: Date.yesterday
      )
    end
  let(:target) { FactoryBot.create(:target, created_by_user: user) }
  let(:exercise) do FactoryBot.create(
      :exercise,
      created_by_user: user,
      target: target
      )
    end
  let(:anothor_exercise) do FactoryBot.create(
      :exercise,
      created_by_user: user,
      target: target,
      name: "ワンレッグカーフレイズ"
      )
    end
    describe "単体バリデーション" do
    describe "weightバリデーション" do
      context "weightが存在しない" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          weight: nil
        )
        end
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
      end
      context "weightが適切なフォーマットで存在している" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          weight: 499.9
        )
        end
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
      end
      context "weightが小数点第3位まである" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          weight: 10.255
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:weight]).to be_present
        end
      end
      context "weightが500.01以上である" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          weight: 500
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:weight]).to be_present
        end
      end
      context "weightが-150以下である" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          weight: -150
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:weight]).to be_present
        end
      end
    end
    describe "repsバリデーション" do
      context "repsが存在しない" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          reps: nil
        )
        end
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
      end
      context "repsが適切な形で存在する" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          reps: 100
        )
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
        end
      end
      context "repsが小数である" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          reps: 99.9
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:reps]).to be_present
        end
      end
      context "repsが101以上である" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          reps: 101
        )
        end
        it "規定のエラーメッセージが含まれる" do
          workout_set.valid?
          expect(workout_set.errors.full_messages).to include (
            "レップ数 は1〜100までの整数で入力してください"
          )
        end
      end
      context "repsが0以下である" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          reps: 0
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:reps]).to be_present
        end
      end
    end
    describe "memoバリデーション" do
      context "メモが存在しない" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          memo: nil
        )
        end
        it "有効である" do
          expect(workout_set).to be_valid
        end
      end
      context "メモが適切な長さで存在する" do
        let(:workout_set) do FactoryBot.build(
          :workout_set,
          memo: "途中でバランスを崩した"
        )
        end
        it "有効である" do
          expect(workout_set).to be_valid
        end
      end
      context "メモが256文字以上" do
        let(:to_long_memo) { "あ"*256 }
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        memo: to_long_memo
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:memo]).to be_present
        end
      end
    end
    describe "set_numberバリデーション" do
      context "set_numberが正しいフォーマットで存在する" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        set_number: 1
        )
        it "有効である" do
          expect(workout_set).to be_valid
        end
        end
      end
      context "set_numberが存在しない" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        set_number: nil
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:set_number]).to be_present
        end
      end
      context "set_numberが0以下である" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        set_number: 0
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:set_number]).to be_present
        end
      end
      context "set_numberが11以上である" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        set_number: 11
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:set_number]).to be_present
        end
      end
    end
    describe "execise_idバリデーション" do
      context "exercise_idが存在する" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        exercise: exercise
        )
        end
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
      end
      context "exercise_idが存在しない" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        exercise: nil
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:exercise]).to be_present
        end
      end
    end
    describe "day_idバリデーション" do
      context "day_idが存在する" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        day: day
        )
        end
        it "有効である" do
          workout_set.valid?
          expect(workout_set).to be_valid
        end
      end
      context "day_idが存在しない" do
        let(:workout_set) do FactoryBot.build(
        :workout_set,
        day: nil
        )
        end
        it "無効である" do
          workout_set.valid?
          expect(workout_set.errors[:day]).to be_present
        end
      end
    end
  end
  describe "uniqueバリデーション" do
  end
  describe "重複バリデーション" do
    context "既存レコードに対して" do
      let!(:existing_workout_set) do FactoryBot.create(
        :workout_set,
        exercise: exercise,
        day: day,
        set_number: 1
      )
      end
      context "exercise、day、set_numberが重複しない" do
         let(:additional_workout_set) do FactoryBot.build(
        :workout_set,
        exercise: anothor_exercise,
        day: anothor_day,
        set_number: 2
        )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "exerciseとdayが重複し、set_numberが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
        :workout_set,
        exercise: exercise,
        day: day,
        set_number: 2
        )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "exercise、set_numberが重複し、dayが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
        :workout_set,
        exercise: exercise,
        day: anothor_day,
        set_number: 1
        )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "day、set_numberが重複し、exerciseが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
        :workout_set,
        exercise: anothor_exercise,
        day: day,
        set_number: 1
        )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "set_numberが重複し、day、exerciseが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
          :workout_set,
          exercise: anothor_exercise,
          day: anothor_day,
          set_number: 1
          )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "dayが重複し、exercise、set_numberが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
          :workout_set,
          exercise: anothor_exercise,
          day: day,
          set_number: 2
          )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "exerciseが重複し、day、set_numberが重複しない" do
        let(:additional_workout_set) do FactoryBot.build(
          :workout_set,
          exercise: exercise,
          day: anothor_day,
          set_number: 2
          )
        end
        it "有効である" do
          additional_workout_set.valid?
          expect(additional_workout_set).to be_valid
        end
      end
      context "exercise、day、set_numberが重複している" do
         let(:additional_workout_set) do FactoryBot.build(
            :workout_set,
            exercise: exercise,
            day: day,
            set_number: 1
          )
         end
        it "無効である" do
          puts additional_workout_set.errors.full_messages
          additional_workout_set.valid?
          expect(additional_workout_set.errors[:set_number]).to be_present
        end
      end
    end
  end
  describe "アソシエーション" do
    describe "belongs_to" do
      it "exeriseに対してbelongs_toの関連を持っている" do
        reflection = WorkoutSet.reflect_on_association(:exercise)
        expect(reflection.macro).to eq :belongs_to
      end
      it "dayに対してbelongs_toの関連を持っている" do
        reflection = WorkoutSet.reflect_on_association(:day)
        expect(reflection.macro).to eq :belongs_to
      end
    end
  end
  describe "コールバック" do
    describe "before_validationコールバック" do
      it "weight,reps,memoの空文字がnilに変換される" do
        workout_set = FactoryBot.build(
          :workout_set,
          weight: " ",
          reps: " ",
          memo: " "
        )
        workout_set.valid?
        expect(workout_set.weight).to eq nil
        expect(workout_set.reps).to eq nil
        expect(workout_set.memo).to eq nil
      end
    end
    describe "after_commitコールバック" do
      it "weight,reps,memoいずれもnilであればそのレコードを削除する" do
         workout_set = FactoryBot.create(
          :workout_set,
          weight: nil,
          reps: nil,
          memo: nil
        )
        expect(workout_set.destroyed?).to eq true
        expect(WorkoutSet.exists?(workout_set.id)).to eq false
      end
    end
  end
end
