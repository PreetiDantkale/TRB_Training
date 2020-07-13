module User::Operation
  class Create < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Form )
    step Contract::Validate()
    step Contract::Persist()
    fail :set_error_response
    step :generate_auth_token

    def set_error_response(ctx, **)
      ctx[:errors] = ctx[:"contract.default"].errors.full_messages
      p ctx[:"contract.default"].errors.full_messages
    end

    def generate_auth_token(ctx, params:,**)
      p "Generating JWT Token..."
      ctx[:token] = {
        auth_token: JsonWebToken.encode({email: params[:email]}),
        email: params[:email],
        name: params[:name],
        age: params[:age]
      }
    end
  end
end
