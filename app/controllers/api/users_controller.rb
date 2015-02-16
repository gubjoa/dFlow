class Api::UsersController < Api::ApiController
	before_filter :check_key
	before_filter -> { validate_rights 'manage_users' }, only: [:create, :update, :destroy]
	before_filter -> { validate_rights 'view_users' }, only: [:index]

	def index
		@response[:users] = User.all
		render_json
	end

	# Creates a User 
	def create
		user = User.new(user_params)
		
		# Save user, or return error message
		if !user.save
			error_msg(ErrorCodes::VALIDATION_ERROR, "Could not create user", user.errors)
			render_json
		else
			@response[:user] = user
			render_json(201)
		end

	end

	# Updates a User
	def update
		user = User.find(params[:id])

		if user.update_attributes(user_params)
			@response[:user] = user
		else
			error_msg(ErrorCodes::VALIDATION_ERROR, "Could not update user", user.errors)
		end

    render_json

	end

  # Renders a specific user object
  def show
    user = User.find_by_id(params[:id])

    if user
      @response[:user] = user
    else
      error_msg(ErrorCodes::OBJECT_ERROR, "Could not find user with id #{params[:id]}")
    end

    render_json
  end

	private

	#Kept secret so that admin functionality cannot be ingested
	def user_params
		params.require(:user).permit(:username, :name, :email, :role)
	end
	

end
