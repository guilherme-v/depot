class StoreController < ApplicationController
  include VisitTracker

  def index
    @products = Product.order(:title)
    increase_visit_counter
  end

end

