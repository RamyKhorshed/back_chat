class Api::V1::UsersController < ActionController::API
  def index
    @users = User.all
    render json: @users
  end

  def show
    id = params[:id].to_i-1
    @user = User.all[id]

    render json: {chats:@user.chats, users: User.all}
  end

  def create
      @user = User.create(username: params["username"], password: params["password"], first_name: params["first_name"], last_name: params["last_name"])
      render json: @user.to_json
  end

  def update
      @user = User.find(params[:user_id])
      snippets = @user.snippets.to_a
      snippets.delete_at(params[:index])
      @user.snippets = snippets
      @user.save

      render json: @user.to_json
  end
end
