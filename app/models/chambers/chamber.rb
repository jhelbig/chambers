module Chambers
  ##
  # Chamber is the moniker for a room.  This model will be the core of the entire Chambers service.
  
  class Chamber < ApplicationRecord

    has_one :key, :class_name => "ChamberKey", primary_key: :uuid, foreign_key: :chamber_uuid

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
    validate :validateChamberRole
    
    after_initialize :setUUID
    before_validation :setRole
    after_save :setKey, if: :local
    
    private

    ##
    # setUUID will generate a RFC 4122 compliant UUID
    # and set the value on the uuid attribute on init
    # no input required and cannot be called directly

    def setUUID()
      self[:uuid] = UUID.generate unless self.uuid
    end

    ##
    # setRole will correctly set the related boolean
    # values depending on if the chamber is a master
    # secondary, or slave.  This is more of a helper
    # method that will set expected values to ensure
    # that validation passes (validateChamberRole).
    #
    # This methods output is skipped if the RAILS_ENV
    # is 'test'.  This ensures that the validation works
    # without crippling integrations for each of access.

    def setRole()
      return if ENV['RAILS_ENV'] == 'test'
      if self.master
        self.slave = false
        self.secondary = false
      end

      if self.secondary
        self.slave = true
        self.master = false
      end
      
      if self.slave
        self.master = false
      end
      
      if !self.master && !self.secondary
        self.slave = true
      end
    end
    
    ##
    # setKey will generate and set the RSA key used for
    # communications between chamber nodes.
    #
    # If the record fails to create, the creation of
    # the chamber record is also rolled back.

    def setKey
      ChamberKey.new({chamber_uuid: self.uuid}).save() unless self.key
    end
    
    ##
    # validateChamberRole is a validation method
    # leveraged by the AR validation rules on this
    # model.  This method ensures that all the
    # boolean values are correctly attributed to
    # a chamber for the specific role it plays in
    # the ecosystem.

    def validateChamberRole()
      # master cannot be secondary
      # master cannot be slave
      # master can only be attributed once
      if self.master
        self.errors.add(:secondary, "master Chambers cannot be marked as secondary") if self.secondary
        self.errors.add(:slave, "master Chambers cannot be marked as slave") if self.slave
        self.errors.add(:master, "master cannot be attributed more than once") if Chamber.where(master: true).where.not(uuid: self.uuid).exists?
      end

      # secondary cannot be master
      # secondary can only be attributed once
      if self.secondary
        self.errors.add(:master, "secondary Chambers cannot be marked as master") if self.master
        self.errors.add(:secondary, "secondary cannot be attributed more than once") if Chamber.where(secondary: true).where.not(uuid: self.uuid).exists?
      end

      # anything not master must be slave
      self.errors.add(:master, "non-master Chambers must be marked as slave") if !self.master && !self.slave
      
      # local can only be attributed once
      self.errors.add(:secondary, "secondary cannot be attributed more than once") if self.local && Chamber.where(local: true).where.not(uuid: self.uuid).exists?
    end

  end

end
