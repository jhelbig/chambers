require 'test_helper'

module Chambers
  class ChambersControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @chamber = chambers_chambers(:one)
    end

    test "should get index" do
      get chambers_url
      assert_response :success
    end

    test "api should get index" do
      get chambers_url, params: { format: 'json' }
      json_body = JSON.parse(response.body)
      assert json_body.is_a?(Array)
      assert json_body.length, Chamber.count
      json_body.each do |chamber|
        assert Chamber.where(uuid: chamber['uuid']).exists?
      end
      assert_response :success
    end

    test "should get new" do
      get new_chamber_url
      assert_response :success
    end

    test "api should get new" do
      get new_chamber_url, params: { format: 'json' }
      json_body = JSON.parse(response.body)
      assert json_body.is_a?(Hash)
      assert_response :success
    end
    
    test "should create chamber" do
      assert_difference('Chamber.count') do
        post chambers_url, params: { chamber: { name: "TestRoom", host: "testroom.chamber.haus", master: false, secondary: false, slave: true, local: false, active: true, level: 1 } }
      end
      assert_redirected_to chamber_url(Chamber.last)
    end

    test "api should create chamber" do
      assert_difference('Chamber.count') do
        post chambers_url, params: { chamber: { name: "TestRoom", host: "testroom.chamber.haus", master: false, secondary: false, slave: true, local: false, active: true, level: 1 }, format: 'json' }
      end
      json_body = JSON.parse(response.body)
      assert json_body.is_a?(Hash)
      assert json_body['name'] == "TestRoom"
      assert_response :success
    end

    test "should show chamber" do
      get chamber_url(@chamber)
      assert_response :success
    end

    test "api should show chamber" do
      get chamber_url(@chamber.uuid), params: { format: 'json' }
      json_body = JSON.parse(response.body)
      assert_response :success
      assert json_body.is_a?(Hash)
      assert json_body['uuid'] == chambers_chambers(:one).uuid
    end

    test "should get edit" do
      get edit_chamber_url(@chamber)
      assert_response :success
    end

    test "should update chamber" do
      patch chamber_url(@chamber), params: { chamber: { level: 5 } }
      assert_redirected_to chamber_url(@chamber)
    end

    test "api should update chamber" do
      patch chamber_url(@chamber.uuid), params: { chamber: { level: 5 }, format: 'json' }
      json_body = JSON.parse(response.body)
      assert json_body.is_a?(Hash)
      assert json_body['level'] == 5
      assert_response :success
    end

    test "should destroy chamber" do
      assert_difference('Chamber.count', -1) do
        delete chamber_url(@chamber)
      end

      assert_redirected_to chambers_url
    end

    test "api should destroy chamber" do
      assert_difference('Chamber.count', -1) do
        delete chamber_url(@chamber.uuid), params: { format: 'json' }
      end
      assert_not Chamber.where(uuid: @chamber.uuid).exists?
      json_body = JSON.parse(response.body)
      assert_response :success
      assert json_body.is_a?(Hash)
    end

  end
end
