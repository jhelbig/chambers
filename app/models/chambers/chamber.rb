module Chambers
  ##
  # Chamber is the moniker for a room.  This model will be the core of the entire Chambers service.
  
  class Chamber < ApplicationRecord

    validates :name, format: { with: /\A[a-zA-Z0-9\-\_\s]+\z/, message: "only allows alphanumeric, hypen(-), underscore(_), spaces( )" }
    validates :name, presence: true
    validates :name, uniqueness: true
    validates :uuid, presence: true
    validates :uuid, uniqueness: true
    validates :uuid, uuid: true
    validates :host, presence: true
    validates :host, uniqueness: true
    validates :level, presence: true
    validates :level, numericality: { only_integer: true }
    
    after_initialize :setUUID
    
    private

    ##
    # setUUID will generate a RFC 4122 compliant UUID
    # and set the value on the uuid attribute on init
    # no input required and cannot be called directly

    def setUUID()
      self[:uuid] = UUID.generate unless self.uuid
    end

  end
end
