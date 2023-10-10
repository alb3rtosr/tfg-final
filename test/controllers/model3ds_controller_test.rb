require "test_helper"

class Model3dsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @model3d = model3ds(:one)
  end

  test "should get index" do
    get model3ds_url
    assert_response :success
  end

  test "should get new" do
    get new_model3d_url
    assert_response :success
  end

  test "should create model3d" do
    assert_difference("Model3d.count") do
      post model3ds_url, params: { model3d: { description: @model3d.description, makes: @model3d.makes, user_id: @model3d.user_id } }
    end

    assert_redirected_to model3d_url(Model3d.last)
  end

  test "should show model3d" do
    get model3d_url(@model3d)
    assert_response :success
  end

  test "should get edit" do
    get edit_model3d_url(@model3d)
    assert_response :success
  end

  test "should update model3d" do
    patch model3d_url(@model3d), params: { model3d: { description: @model3d.description, makes: @model3d.makes, user_id: @model3d.user_id } }
    assert_redirected_to model3d_url(@model3d)
  end

  test "should destroy model3d" do
    assert_difference("Model3d.count", -1) do
      delete model3d_url(@model3d)
    end

    assert_redirected_to model3ds_url
  end
end
