module Chambers

  ##
  # ChamberKey is responsible for
  # maintaining the RSA keys for any
  # chamber>chamber communication.
  #
  # The public key will be stored in the
  # database and shared among all nodes.
  #
  # The private key will live on the node
  # and never be exported.

  class ChamberKey < ApplicationRecord

    belongs_to :chamber, class_name: "Chamber", foreign_key: :chamber_uuid, primary_key: :uuid

    validates :chamber_uuid, presence: true
    validates :chamber_uuid, uniqueness: true
    validates :public, presence: true
    validates :public, uniqueness: true
    #validates_associated :chamber

    after_initialize :setRSA


    private

    ##
    # setRSA will generate a RSA keyset
    # for secure communications between
    # chambers
    def setRSA
      unless self.public
        require 'openssl'
        rsa_private = OpenSSL::PKey::RSA.generate 4096
        self.public = rsa_private.public_key
      end
    end

  end
end
