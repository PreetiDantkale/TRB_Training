module User::Contract
  class Form < Reform::Form
    property :name
    property :age
    property :email

    validates :name, :age, :email, presence: true
    validates_uniqueness_of :email
  end
end
