class DiscussionTag < ApplicationRecord
  belongs_to :discussion
  belongs_to :tag

  validates :discussion_id, presence: true
  validates :tag_id, presence: true
end
