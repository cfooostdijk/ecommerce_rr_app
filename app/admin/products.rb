ActiveAdmin.register Product do
  permit_params :title, :description, :price, :image_url

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :image do |product|
      image_tag(product.image_url, size: "50x50") if product.image_url.present?
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :price
      row :image do |product|
        image_tag(product.image_url, size: "200x200") if product.image_url.present?
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :price
      f.input :image_url
    end
    f.actions
  end

  filter :title
  filter :description
  filter :price

  action_item :import, only: :index do
    link_to 'Import Products', action: :import
  end

  collection_action :import, method: :get do
    result = FetchProducts.call

    if result.success?
      redirect_to admin_products_path, notice: "Products imported successfully!"
    else
      redirect_to admin_products_path, alert: "Failed to import products: #{result.message}"
    end
  end
end
