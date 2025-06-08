class CreateDiscussionTags < ActiveRecord::Migration[8.0]
  def change
    create_table :discussion_tags do |t|
      t.references :discussion, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
