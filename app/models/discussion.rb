class Discussion < ApplicationRecord
  has_many :discussion_tags, dependent: :destroy
  has_many :tags, through: :discussion_tags

  validates :topic, presence: true
  validates :description, presence: true
end
