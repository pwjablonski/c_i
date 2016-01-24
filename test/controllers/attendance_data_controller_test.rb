require 'test_helper'

class AttendanceDataControllerTest < ActionController::TestCase
  setup do
    @attendance_datum = attendance_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendance_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance_datum" do
    assert_difference('AttendanceDatum.count') do
      post :create, attendance_datum: { date: @attendance_datum.date, enrollment_id: @attendance_datum.enrollment_id, present: @attendance_datum.present }
    end

    assert_redirected_to attendance_datum_path(assigns(:attendance_datum))
  end

  test "should show attendance_datum" do
    get :show, id: @attendance_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendance_datum
    assert_response :success
  end

  test "should update attendance_datum" do
    patch :update, id: @attendance_datum, attendance_datum: { date: @attendance_datum.date, enrollment_id: @attendance_datum.enrollment_id, present: @attendance_datum.present }
    assert_redirected_to attendance_datum_path(assigns(:attendance_datum))
  end

  test "should destroy attendance_datum" do
    assert_difference('AttendanceDatum.count', -1) do
      delete :destroy, id: @attendance_datum
    end

    assert_redirected_to attendance_data_path
  end
end
