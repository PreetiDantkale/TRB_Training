module User::Operation
  class Create < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build(constant: User::Contract::Form )
    step Contract::Validate(key: :user)
    # step Contract::Persist()
    # fail :set_error_response
    #
    # def set_error_response(ctx, **)
    #   ctx[:errors] = ctx[:"contract.default"].errors.full_messages
    # end

  end
end
