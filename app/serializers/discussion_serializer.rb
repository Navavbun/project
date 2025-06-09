class DiscussionSerializer < ActiveModel::Serializer
  attributes :topic, :description, :created_at
end
