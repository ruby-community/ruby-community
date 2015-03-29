class CreateFrequentlyAskedQuestions < ActiveRecord::Migration
  def change
    create_table :frequently_asked_questions do |t|
      t.string  :topic
      t.integer :position
      t.text    :question
      t.text    :answer

      t.timestamps
    end

    add_index :frequently_asked_questions, :topic
  end
end
