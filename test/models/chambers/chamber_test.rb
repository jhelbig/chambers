require 'test_helper'

module Chambers
  class ChamberTest < ActiveSupport::TestCase

    test "chamber must have a name" do
      chamber = Chamber.new()
      assert_not chamber.save
    end
    
    test "chamber name can only be [a-zA-Z0-9-_]" do
      chamber = Chamber.new({
        name: "This is a test!",
        host: "192.168.0.1",
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber level can only be numerical" do
      chamber = Chamber.new({
        name: "This is a test",
        host: "192.168.0.1",
        active: true,
        level: "a"
      })
      assert_not chamber.save
    end

    test "chamber name must be unique" do
      chamber = Chamber.new({
        name: "Kitchen",
        host: "192.168.0.1",
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber host must be unique" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.13",
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber id must be unique" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        active: true,
        level: 1
      })
      assert chamber.save
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber host can be IPv4" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        active: true,
        level: 1
      })
      assert chamber.save
    end

    test "chamber host can be IPv6" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "87dc:1f06:aef1:1a0a:fe3e:ca3e:d8c6:30c5",
        active: true,
        level: 1
      })
      assert chamber.save
    end

    test "chamber host can be domain" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "kitchen.chambers.house",
        active: true,
        level: 1
      })
      assert chamber.save
    end



  end
end
