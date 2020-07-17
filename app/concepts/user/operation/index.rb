module User::Operation
  class Index < Trailblazer::Operation

    step :valid_user?
    step :list

    def valid_user?(ctx, **)
      true
    end

    def list(ctx, **)
      ctx[:model] = User.all
    end
  end
end
