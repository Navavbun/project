class Comment < ApplicationRecord
  belongs_to :discussion

  validates :text, presence: true
end
