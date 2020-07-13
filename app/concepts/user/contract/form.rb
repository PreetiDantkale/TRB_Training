module User::Contract
  class Form < Reform::Form
    property :name
    property :age
    property :email
    property :password

    validates :name, :age, :email, :password, presence: true
    validates_uniqueness_of :email
  end
end
