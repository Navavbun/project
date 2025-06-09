class Discussion < ApplicationRecord
  has_many :discussion_tags, dependent: :destroy
  has_many :tags, through: :discussion_tags
  has_many :comments, dependent: :destroy

  validates :topic, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id topic description created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[discussion_tags tags comments]
  end
end
