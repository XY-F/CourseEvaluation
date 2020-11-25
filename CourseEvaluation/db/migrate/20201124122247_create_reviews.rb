class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.references :comment_id, null: false
      t.references :user_id, null: false

      t.timestamps
    end
  end
end
