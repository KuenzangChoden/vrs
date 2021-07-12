json.extract! report, :id, :name, :email, :phone, :address, :vtype, :created_at, :updated_at
json.url report_url(report, format: :json)
