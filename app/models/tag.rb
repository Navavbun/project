class Tag < ApplicationRecord
  has_many :discussion_tags, dependent: :destroy
  has_many :discussions, through: :discussion_tags

  validates :name, presence: true, uniqueness: true
end
