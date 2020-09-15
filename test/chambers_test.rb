require 'test_helper'

class Chambers::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Chambers
  end

  test "SecurePayload imported" do
    assert_kind_of Class, Chambers::SecurePayload
  end

  test "SecurePayload encryption and decryption" do
    require 'openssl'
    require 'basic_ssl'
    rsa_private = OpenSSL::PKey::RSA.generate 4096
    payload = { my_value: "is secret", please: "don't hax me", taze_me: false }.to_json
    enc_str = Chambers::SecurePayload.new(rsa_private.public_key.to_pem, payload).encrypt()
    assert_not enc_str == payload.to_json
    dec_str = Chambers::SecurePayload.new(rsa_private.to_pem, enc_str).decrypt()
    assert dec_str == payload
  end
end
