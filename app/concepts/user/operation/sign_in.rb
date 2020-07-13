module User::Operation
  class SignIn < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::SignIn )
    step Contract::Validate()
    step :authenticate_user
    pass :issue_token
    fail :set_error_response

    def authenticate_user(ctx, params:, **)
      p "Authenticating...."
      User.where(email: params[:email], password: params[:password]).exists?
    end

    def issue_token(ctx, params:, **)
      p "Generating Token..."
      ctx[:token] = {
        auth_token: JsonWebToken.encode({email: params[:email]}),
        email: params[:email],
        name: User.find_by(email: params[:email]).name,
        age: User.find_by(age: params[:age]).age
      }
    end

    def set_error_response(ctx, params:, **)
      p "Invalid Credentials"
      password = User.where(email: params[:email]).first&.password
      ctx[:errors] = {password: 'Invalid'} if password != params[:password]
    end
  end
end
