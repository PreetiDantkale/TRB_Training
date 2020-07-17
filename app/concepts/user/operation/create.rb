module User::Operation
  class Create < Trailblazer::Operation

    # step Model(User, :new)
    # step Contract::Build(constant: User::Contract::Form )
    step Subprocess(User::Operation::New)
    step Contract::Validate(key: :user)
    step Contract::Persist()
    fail :set_error_response
    step :generate_token

    def set_error_response(ctx, **)
      ctx[:errors] = ctx[:"contract.default"].errors.full_messages
      p ctx[:"contract.default"].errors.full_messages
    end

    def generate_token(ctx, params:, **)
      p "Generating JWT Token..."
      ctx[:token] = {
        token: JWT.encode(params[:email], params[:password], 'none'),
        email: params[:email],
        name: params[:name],
        age: params[:age]
      }
    end
  end
end
