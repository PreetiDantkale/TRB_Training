module User::Operation
  class Demo < Trailblazer::Operation

    step :create_user
    step :address_present?, Output(:failure) => Id(:send_email)
    step :create_address

    fail :send_email
    step :set_response_data

    def create_user(ctx, **)
      ctx[:user] = User.create(name: 'Preeti')
    end

    def address_present?(ctx, **)
      false
    end

    def create_address(ctx, **)
      p "Creating Address...."
    end

    def send_email(ctx, **)
      p "Mail sent to..."
    end

    def set_response_data(ctx, **)
      p 'User created..'
    end
  end
end
