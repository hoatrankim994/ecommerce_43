class Admin::AdminController < ApplicationController
  layout "admin/application"

  def index; end

  def require_admin
    return if current_user && current_user.admin?
    flash[:danger] = t "controller.orders.role"
    redirect_to root_url
  end
end
