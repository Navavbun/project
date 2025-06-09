class DetailedDiscussionSerializer < ActiveModel::Serializer
  attributes :topic, :description, :created_at

  has_many :tags

  has_many :comments

  def comments
    page = instance_options[:comments_page] || 1
    per = instance_options[:comments_per] || 10
    object.comments.page(page).per(per)
  end
end
