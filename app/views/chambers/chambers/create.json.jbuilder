if @chamber.id.present?
    json.(@chamber, :id, :uuid, :name, :host, :active, :level)
else
    json.(@chamber, :errors)
end