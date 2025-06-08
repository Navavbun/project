class DiscussionSerializer < ActiveModel::Serializer
  attributes :topic, :description, :created_at

  has_many :tags
  has_many :comments
end
