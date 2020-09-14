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
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber level can only be numerical" do
      chamber = Chamber.new({
        name: "This is a test",
        host: "192.168.0.1",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: "a"
      })
      assert_not chamber.save
    end

    test "chamber name must be unique" do
      chamber = Chamber.new({
        name: "Kitchen",
        host: "192.168.0.1",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "chamber host must be unique" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.13",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "master chamber cannot be marked as slave" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: true,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "master chamber cannot be marked as secondary" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: true,
        slave: false,
        secondary: true,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "master chamber can only be attributed once" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: true,
        slave: false,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
      chamber = Chamber.new({
        name: "Kitchen Sink2",
        host: "192.168.1.30",
        master: true,
        slave: false,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "secondary chamber can only be attributed once" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: false,
        slave: true,
        secondary: true,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
      chamber = Chamber.new({
        name: "Kitchen Sink2",
        host: "192.168.1.30",
        master: false,
        slave: true,
        secondary: true,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end

    test "secondary chamber must be attributed as slave" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: false,
        slave: false,
        secondary: true,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end
    
    test "non-master chamber must be attributed as slave" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: false,
        slave: false,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end
    
    test "local chamber can only be attributed once" do
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: false,
        slave: false,
        secondary: false,
        local: true,
        active: true,
        level: 1
      })
      chamber = Chamber.new({
        name: "Kitchen Sink",
        host: "192.168.1.29",
        master: false,
        slave: false,
        secondary: false,
        local: true,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end
    
    test "chamber id must be unique" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert_not chamber.save
    end
    
    test "chamber host can be IPv4" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "192.168.0.1",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
    end
    
    test "chamber host can be IPv6" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "87dc:1f06:aef1:1a0a:fe3e:ca3e:d8c6:30c5",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
    end
    
    test "chamber host can be domain" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "kitchen.chambers.house",
        master: false,
        slave: true,
        secondary: false,
        local: false,
        active: true,
        level: 1
      })
      assert chamber.save
    end

    test "local chamber must have rsa key" do
      chamber = Chamber.new({
        name: "Test Kitchen",
        host: "kitchen.chambers.house",
        master: false,
        slave: true,
        secondary: false,
        local: true,
        active: true,
        level: 1
      })
      assert chamber.save
      chamber.reload
      assert_not chamber.key.nil?
      assert chamber.key.chamber_uuid == chamber.uuid
    end



  end
end
