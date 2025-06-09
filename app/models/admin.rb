class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # For ActiveAdmin/Ransack compatibility
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at current_sign_in_at sign_in_count]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
