class Tag < ApplicationRecord
  has_many :discussions, through: :discussion_tags
  has_many :discussion_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
