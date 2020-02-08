class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  include VisitTracker

  before_action :set_cart

  def index
    @products = Product.order(:title)
    increase_visit_counter
  end
end
