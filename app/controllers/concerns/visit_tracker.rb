module VisitTracker
  private

  def increase_visit_counter
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end

  def reset_visit_counter
    session[:counter] = 0
  end
end