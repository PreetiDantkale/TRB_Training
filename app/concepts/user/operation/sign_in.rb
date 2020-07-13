module User::Operation
  class SignIn < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::SignIn )
    step Contract::Validate()
    step :authenticate_user
    pass :issue_token
    fail :set_error_response

    def authenticate_user(ctx, params:, **)
      User.where(email: params[:email], password_digest: params[:password_digest]).exists?
    end

    def issue_token(ctx, params:, **)
      ctx[:token] = {
        auth_token: JsonWebToken.encode({email: params[:email]}),
        email: params[:email],
        name: User.find_by(email: params[:email]).name,
        age: User.find_by(age: params[:age]).age
      }
    end

    def set_error_response(ctx, params:, **)
      password = User.where(email: params[:email]).first&.password_digest
      ctx[:errors] = {password: 'Invalid'} if password != params[:password_digest]
    end
  end
end
