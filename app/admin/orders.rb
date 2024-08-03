ActiveAdmin.register Order do
  permit_params :customer_first_name, :customer_last_name, :customer_email, :total, order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :customer_first_name
    column :customer_last_name
    column :customer_email
    column :total
    column "Products" do |order|
      order.order_items.map do |oi|
        link_to(admin_product_path(oi.product)) do
          "#{image_tag(oi.product.image_url, size: "50x50")} #{oi.product.title}".html_safe
        end
      end.join("<br>").html_safe
    end
    actions
  end

  show do
    attributes_table do
      row :customer_first_name
      row :customer_last_name
      row :customer_email
      row :total
      row :created_at
      row :updated_at
    end

    panel "Products" do
      table_for order.order_items do
        column "Product" do |order_item|
          link_to admin_product_path(order_item.product) do
            "#{image_tag(order_item.product.image_url, size: "50x50")} #{order_item.product.title}".html_safe
          end
        end
        column :quantity
        column :price
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :customer_first_name
      f.input :customer_last_name
      f.input :customer_email
      f.input :total
    end

    f.has_many :order_items, allow_destroy: true, new_record: true do |oi|
      oi.input :product, as: :select, collection: Product.all.collect { |p| [p.title, p.id] }
      oi.input :quantity
      oi.input :price
    end

    f.actions
  end

  actions :all, except: [:edit, :update]

  filter :customer_first_name
  filter :customer_last_name
  filter :customer_email
  filter :total
  filter :created_at
  filter :updated_at
end
