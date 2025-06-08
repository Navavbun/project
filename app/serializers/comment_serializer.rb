class CommentSerializer < ActiveModel::Serializer
  attributes :text, :user

  def user
    UserSerializer.new(object.user)
  end
end
