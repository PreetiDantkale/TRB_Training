class OrdersController < ApplicationController

  def bill_amount
    result = Order::Operation::BillAmount.(params: params)
    render json: {bill_amount: result[:bill_amount]}
  end
end
