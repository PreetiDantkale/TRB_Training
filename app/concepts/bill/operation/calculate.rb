module Bill::Operation
  class BillAmount < Trailblazer::Operation

    step :valid_user
    step :list
    fail :set_error_response
    pass :set_response_data

    def valid_user(ctx, **)
      true
    end

    def list(ctx, **)
      ctx[:users] = User.all
    end

    def set_error_response(ctx, **)
      ctx[:errors] = 'User Invalid...'
    end

    def set_response_data(ctx, **)
      ctx[:response] = 'Users loaded successfully..'
    end
  end
end
