ActiveAdmin.register Tag do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def ransackable_attributes(auth_object = nil)
      %w[id name created_at updated_at]
    end

    def ransackable_associations(auth_object = nil)
      %w[discussion_tags discussions]
    end
  end
end
