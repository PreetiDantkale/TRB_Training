module Order::Operation
  class BillAmount < Trailblazer::Operation

    step :calculate_bill
    step :self_pickup?
    pass :set_response_data
    fail :add_pick_up_charges
    # step :send_email

    def calculate_bill(ctx, params:, **)
      ctx[:sum] = 0
      order_items = params[:order_items]
      order_items.each do |order|
        ctx[:sum] += order[:price]
      end
    end

    def self_pickup?(ctx, params:, **)
      params[:self_pick] == true
    end

    def add_pick_up_charges(ctx, sum:, params:, **)
      ctx[:bill_amount] = sum + 0.05*sum
      UserMailer.bill_amount(ctx[:bill_amount], params[:email]).deliver_now
    end

    def set_response_data(ctx, sum:, params:, **)
      ctx[:bill_amount] =  sum
      UserMailer.bill_amount(ctx[:bill_amount], params[:email]).deliver_now
    end

    # def send_email(ctx, **)
    # end
  end
end
