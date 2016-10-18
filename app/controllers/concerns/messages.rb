module Messages
  extend ActiveSupport::Concern

  def success(model, action)
    flash[:notice] = "#{model} #{action} successfully."
  end

  def error(model, action)
    flash[:alert] = "Error occured. #{model} not #{action}."
  end
end

#
