module User::Contract
  class SignIn < Reform::Form
    property :email
    property :password

    validates :email, :password, presence: true
  end
end
