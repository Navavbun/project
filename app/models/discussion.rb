class Discussion < ApplicationRecord
  has_many :discussion_tags, dependent: :destroy
  has_many :tags, through: :discussion_tags
  has_many :comments, dependent: :destroy

  validates :topic, presence: true
  validates :description, presence: true
end
