class AddDiscussionIdToComments < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :discussion, null: false, foreign_key: true
  end
end
