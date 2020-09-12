if @chamber.id.present?
    json.(@chamber, :uuid, :name, :host, :active, :level)
else
    json.(@chamber, :errors)
end