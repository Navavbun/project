class Tag < ApplicationRecord
  has_many :discussion_tags, dependent: :destroy
  has_many :discussions, through: :discussion_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[discussion_tags discussions]
  end
end
