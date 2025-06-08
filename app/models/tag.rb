class Tag < ApplicationRecord
  has_many :discussions
  has_many :discussion_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
