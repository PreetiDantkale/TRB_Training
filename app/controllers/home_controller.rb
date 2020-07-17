class HomeController < ApplicationController
  def index
    return render cell(Home::Cell::Index)
  end
end
