ActiveAdmin.register Product do
  permit_params :title, :description, :price, :image_url

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :api_id
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
      row :api_id
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
      f.input :api_id
      f.input :image_url
    end
    f.actions
  end

  filter :title
  filter :description
  filter :price
  filter :api_id

  action_item :api_import, only: :index do
    link_to 'API Import Products', action: :import, source: :api
  end

  collection_action :import, method: :get do
    strategy = params[:source]

    if strategy.present?
      ProductImportWorker.perform_async(strategy)
      redirect_to admin_products_path, notice: 'Products import task has been enqueued!'
    else
      redirect_to admin_products_path, alert: 'No source specified.'
    end
  end

  action_item :csv_import, only: :index do
    link_to 'CSV Import Products', action: :csv_import
  end

  collection_action :csv_import, method: :get do
    render 'admin/products/import_csv', locals: { action: :import_csv, source: :csv }
  end

  collection_action :import_csv, method: :post do
    file = params.dig(:csv_import, :file)
    strategy = params.dig(:csv_import,:source)

    if file.present? && strategy.present?
      result = ProductImportStrategy.new(strategy, file).execute

      if result[:success]
        redirect_to admin_products_path, notice: 'Products imported successfully!'
      else
        redirect_to admin_products_path, alert: "Failed to import products: #{result[:message]}"
      end
    else
      redirect_to admin_products_path, alert: 'No file providedor or No source specified..'
    end
  end
end
