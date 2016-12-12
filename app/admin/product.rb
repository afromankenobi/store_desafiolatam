ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form(html: { multipart: true }) do |f|
    inputs "Product..." do
      input :name
      input :stock
      input :price
      input :category_id, as: :select, collection: Category.all
      input :photo, as: :file
    end
    actions
  end

  permit_params :category_id, :name, :stock, :photo, :price
end
