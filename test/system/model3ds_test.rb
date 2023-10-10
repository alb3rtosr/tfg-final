require "application_system_test_case"

class Model3dsTest < ApplicationSystemTestCase
  setup do
    @model3d = model3ds(:one)
  end

  test "visiting the index" do
    visit model3ds_url
    assert_selector "h1", text: "Model3ds"
  end

  test "should create model3d" do
    visit model3ds_url
    click_on "New model3d"

    fill_in "Description", with: @model3d.description
    fill_in "Makes", with: @model3d.makes
    fill_in "User", with: @model3d.user_id
    click_on "Create Model3d"

    assert_text "Model3d was successfully created"
    click_on "Back"
  end

  test "should update Model3d" do
    visit model3d_url(@model3d)
    click_on "Edit this model3d", match: :first

    fill_in "Description", with: @model3d.description
    fill_in "Makes", with: @model3d.makes
    fill_in "User", with: @model3d.user_id
    click_on "Update Model3d"

    assert_text "Model3d was successfully updated"
    click_on "Back"
  end

  test "should destroy Model3d" do
    visit model3d_url(@model3d)
    click_on "Destroy this model3d", match: :first

    assert_text "Model3d was successfully destroyed"
  end
end
