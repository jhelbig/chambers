#require "application_system_test_case"
#
#module Chambers
#  class ChambersTest < ApplicationSystemTestCase
#    setup do
#      @chamber = chambers_chambers(:one)
#    end
#
#    test "visiting the index" do
#      visit chambers_url
#      assert_selector "h1", text: "Chambers"
#    end
#
#    test "creating a Chamber" do
#      visit chambers_url
#      click_on "New Chamber"
#
#      click_on "Create Chamber"
#
#      assert_text "Chamber was successfully created"
#      click_on "Back"
#    end
#
#    test "updating a Chamber" do
#      visit chambers_url
#      click_on "Edit", match: :first
#
#      click_on "Update Chamber"
#
#      assert_text "Chamber was successfully updated"
#      click_on "Back"
#    end
#
#    test "destroying a Chamber" do
#      visit chambers_url
#      page.accept_confirm do
#        click_on "Destroy", match: :first
#      end
#
#      assert_text "Chamber was successfully destroyed"
#    end
#  end
#end
