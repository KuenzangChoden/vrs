require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "Reports"
  end

  test "creating a Report" do
    visit reports_url
    click_on "New Report"

    fill_in "Address", with: @report.address
    fill_in "Email", with: @report.email
    fill_in "Name", with: @report.name
    fill_in "Phone", with: @report.phone
    fill_in "Vtype", with: @report.vtype
    click_on "Create Report"

    assert_text "Report was successfully created"
    click_on "Back"
  end

  test "updating a Report" do
    visit reports_url
    click_on "Edit", match: :first

    fill_in "Address", with: @report.address
    fill_in "Email", with: @report.email
    fill_in "Name", with: @report.name
    fill_in "Phone", with: @report.phone
    fill_in "Vtype", with: @report.vtype
    click_on "Update Report"

    assert_text "Report was successfully updated"
    click_on "Back"
  end

  test "destroying a Report" do
    visit reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Report was successfully destroyed"
  end
end
