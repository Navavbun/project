ActiveAdmin.register Discussion do
  permit_params :topic, :description

  controller do
    def ransackable_attributes(auth_object = nil)
      %w[id topic description created_at updated_at]
    end

    def ransackable_associations(auth_object = nil)
      %w[discussion_tags tags comments]
    end
  end
end
