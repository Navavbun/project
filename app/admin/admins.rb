ActiveAdmin.register Admin do
  permit_params :email, :password, :password_confirmation

  controller do
    def ransackable_attributes(auth_object = nil)
      %w[id email created_at updated_at current_sign_in_at sign_in_count]
    end

    def ransackable_associations(auth_object = nil)
      []
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
