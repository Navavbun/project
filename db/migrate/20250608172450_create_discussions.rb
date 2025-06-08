class CreateDiscussions < ActiveRecord::Migration[8.0]
  def change
    create_table :discussions do |t|
      t.string :topic
      t.string :description
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
