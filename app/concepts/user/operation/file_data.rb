require 'csv'
module User::Operation
  class FileData < Trailblazer::Operation

    step :empty_file?, Output(:failure) => Id(:empty_file_error)
    fail :empty_file_error, fail_fast: true
    step :convert_file_data_to_json, Output(:success) => Track(:validate_data), Output(:failure) => Track(:error_in_json)
    step :set_error_for_conversion, magnetic_to: :error_in_json
    step :json_validate, magnetic_to: :validate_data

    def empty_file?(ctx, **)
      !File.zero?("app/concepts/user/operation/user_data.csv")
    end

    def empty_file_error(ctx, **)
      p "Oops.. File is empty..."
    end

    def convert_file_data_to_json(ctx, **)
      p "converting file data to json.."
      headers = CSV.read("app/concepts/user/operation/user_data.csv", headers: true).headers
      # data = File.open("app/concepts/user/operation/user_data.csv").read
      # json = CSV.parse(data).as_json
      return true if headers == ['name', 'dob', 'mail']
      false
    end

    def set_error_for_conversion(ctx, **)
      p "Conversion Error.. Incorrect Data/Keys."
      csv = CSV.open('app/concepts/user/operation/user_data.csv', 'w')
      csv << ['Conversion Error.. Incorrect Data/Keys.']
    end

    def json_validate(ctx,  **)
      p "Validating json..."
      csv = CSV.read('app/concepts/user/operation/user_data.csv','a+')
      csv.shift
      csv.each do |row|
        age = Time.zone.now.year - row[1].to_date.year
        if URI::MailTo::EMAIL_REGEXP.match?(row[2]) and age > 18
          User.create(name: row[0], age: age, email: row[2])
        else
          row << 'Some Error'
        end
      end
    end
  end
end
