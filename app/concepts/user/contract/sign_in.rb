module User::Contract
  class SignIn < Reform::Form
    property :email
    property :password_digest

    validates :email, :password_digest, presence: true
  end
end
