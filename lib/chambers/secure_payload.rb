module Chambers

  ##
  # SecurePayload will turn the provided payload into
  # a signed and encrypted JWT to allow communication
  # between two chamber nodes.
  #
  # A public RSA key is required to encrypt, and the
  # private key(presumably on the recipient) is used
  # to decrypt.
  #
  # A big thank you to the work that Adam Cooke did.
  # Almost all of the code was taken from the basic_ssl
  # gem, https://github.com/adamcooke/basicssl
  # It just needed a couple modifications to work with
  # the latest versions of openssl.
  #
  #The MIT License (MIT)
  #
  #Copyright (c) 2010 Adam Cooke
  #
  #Permission is hereby granted, free of charge, to any person obtaining a copy
  #of this software and associated documentation files (the "Software"), to deal
  #in the Software without restriction, including without limitation the rights
  #to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  #copies of the Software, and to permit persons to whom the Software is
  #furnished to do so, subject to the following conditions:
  #
  #The above copyright notice and this permission notice shall be included in
  #all copies or substantial portions of the Software.
  #
  #THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  #IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  #FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  #AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  #LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  #OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  #THE SOFTWARE.
  #

  class SecurePayload
    require 'openssl'

    @@key = nil
    @@payload = nil
    
    attr_reader :token

    def initialize(key, payload)
      @@key = key
      @@payload = payload
    end

    ## Returns an Base64 encoded string with encryption
    def encrypt
      aes_encrypt = OpenSSL::Cipher.new('AES-256-CBC').encrypt
      aes_encrypt.key = aes_key = aes_encrypt.random_key
      crypt = aes_encrypt.update(@@payload) << aes_encrypt.final
      encrypted_key = rsa_key(@@key).public_encrypt(aes_key)
      [Base64.encode64(encrypted_key), Base64.encode64(crypt)].join("|")
    end

    ## Return the raw string after decryption & decoding
    def decrypt
      encrypted_key, crypt = @@payload.split("|").map{|a| Base64.decode64(a) }
      aes_key = rsa_key(@@key).private_decrypt(encrypted_key)
      aes_decrypt = OpenSSL::Cipher.new('AES-256-CBC').decrypt
      aes_decrypt.key = aes_key
      aes_decrypt.update(crypt) << aes_decrypt.final
    end
    
    ## Return a signature for the string
    def sign(key, string)
      Base64.encode64(rsa_key(key).sign(OpenSSL::Digest::SHA1.new, string))
    end

    ## Verify the string and signature
    def verify(key, signature, string)
      rsa_key(key).verify(OpenSSL::Digest::SHA1.new, Base64.decode64(signature), string)
    end

    private

    def rsa_key(key)
      OpenSSL::PKey::RSA.new(key)
    end

  end
end