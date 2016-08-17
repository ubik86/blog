module ApplicationHelper


  # this helper method checks active controller and return .active used in application/layout
  def active_controller(name)
    controller.controller_name==name ? 'active' : nil
  end
end
