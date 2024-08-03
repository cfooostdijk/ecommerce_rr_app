ActiveAdmin.register Order do
  permit_params :customer_first_name, :customer_last_name, :customer_email, :total, :product_id

  index do
    selectable_column
    id_column
    column :customer_first_name
    column :customer_last_name
    column :customer_email
    column :total
    column :product do |order|
      link_to order.product.title, admin_product_path(order.product)
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :customer_first_name
      f.input :customer_last_name
      f.input :customer_email
      f.input :total
      f.input :product, as: :select, collection: Product.all.collect { |p| [p.title, p.id] }
    end
    f.actions
  end

  actions :all, except: [:edit, :update]

  filter :customer_first_name
  filter :customer_last_name
  filter :customer_email
  filter :total
  filter :product, as: :select, collection: Product.all.collect { |p| [p.title, p.id] }
end
