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
    validate :validateChamberRole
    
    after_initialize :setUUID
    before_validation :setRole
    
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
    # method that will set expcted values to ensure
    # that validation passes (validateChamberRole).

    def setRole()
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
        self.errors[:base] << "master Chambers cannot be marked as secondary" if self.secondary
        self.errors[:base] << "master Chambers cannot be marked as slave" if self.slave
        self.errors[:base] << "master cannot be attributed more than once" if Chamber.where(master: true).where.not(uuid: self.uuid).exists?
      end

      # secondary cannot be master
      # secondary can only be attributed once
      if self.secondary
        self.errors[:base] << "secondary Chambers cannot be marked as master" if self.master
        self.errors[:base] << "secondary cannot be attributed more than once" if Chamber.where(secondary: true).where.not(uuid: self.uuid).exists?
      end

      # anything not master must be slave
      self.errors[:base] << "non-master Chambers must be marked as slave" if !self.master && !self.slave
      
      # local can only be attributed once
      self.errors[:base] << "secondary cannot be attributed more than once" if self.local && Chamber.where(local: true).where.not(uuid: self.uuid).exists?
    end

  end

end
