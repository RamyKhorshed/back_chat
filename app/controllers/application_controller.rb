class ApplicationController < ActionController::Base

  def current_user
    @user ||= User.find_by(id: user_id)
  end

  def user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    begin
       JWT.decode(request.headers['Authorization'], "supersecretcode")
     rescue JWT::DecodeError
      [{}]
     end
  end

end
