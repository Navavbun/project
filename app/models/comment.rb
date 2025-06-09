class Comment < ApplicationRecord
  belongs_to :discussion

  validates :text, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id text discussion_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[discussion]
  end
end
