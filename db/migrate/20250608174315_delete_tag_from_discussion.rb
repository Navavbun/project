class DeleteTagFromDiscussion < ActiveRecord::Migration[8.0]
  def change
    remove_reference :discussions, :tag, foreign_key: true
  end
end
