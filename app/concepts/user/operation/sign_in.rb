module User::Operation
  class SignIn < Trailblazer::Operation
    step Model(User, :find_by, :email)
    step Contract::Build(constant: User::Contract::SignIn )
    step Contract::Validate()
    step :authenticate_user
    pass :issue_token
    fail :set_error_response

    def authenticate_user(ctx, params:, **)
      p "Authenticating...."
      ctx[:model].password == params[:password]
    end

    def issue_token(ctx, params:, **)
      p "Generating Token..."
      token = JWT.encode(params[:email], params[:password], 'none')
      p "Your Token #{token}"
      ctx[:token] = {
        token: token,
        email: params[:email],
        name: User.find_by(email: params[:email])&.name,
        age: User.find_by(age: params[:age])&.age
      }
    end

    def set_error_response(ctx, params:, **)
      p "Invalid Credentials"
      ctx[:errors] = {password: 'Invalid'}
    end
  end
end
