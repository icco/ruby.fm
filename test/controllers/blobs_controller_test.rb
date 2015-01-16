require 'test_helper'

class BlobsControllerTest < ActionController::TestCase
  setup do
    @blob = blobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blob" do
    assert_difference('Blob.count') do
      post :create, blob: { location: @blob.location }
    end

    assert_redirected_to blob_path(assigns(:blob))
  end

  test "should show blob" do
    get :show, id: @blob
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blob
    assert_response :success
  end

  test "should update blob" do
    patch :update, id: @blob, blob: { location: @blob.location }
    assert_redirected_to blob_path(assigns(:blob))
  end

  test "should destroy blob" do
    assert_difference('Blob.count', -1) do
      delete :destroy, id: @blob
    end

    assert_redirected_to blobs_path
  end
end
