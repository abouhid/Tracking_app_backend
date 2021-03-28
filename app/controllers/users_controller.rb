# app/controllers/users_controller.rb
class UsersController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    Measurement.create(name:"Left Arm",created_by:user.id)
    Measurement.create(name:"Right Arm",created_by:user.id)
    Measurement.create(name:"Left Leg",created_by:user.id)
    Measurement.create(name:"Right Leg",created_by:user.id)
    Measurement.create(name:"Waist",created_by:user.id)
    Measurement.create(name:"Abdomen",created_by:user.id)

    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
