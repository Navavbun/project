class DiscussionTag < ApplicationRecord
  belongs_to :discussion
  belongs_to :tag

  def self.ransackable_attributes(auth_object = nil)
    %w[id discussion_id tag_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[discussion tag]
  end
end
