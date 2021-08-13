class ApplicationController < ActionController::Base

  include Pagy::Backend

  # before_action :test_flash

  def test_flash
    set_flash_message(:success, 'Success')
    set_flash_message(:notice, 'Notice')
    set_flash_message(:error, 'Error')
    set_flash_message(:alert, 'Alert')
  end

  def authenticate_mod!
    unless mod_signed_in?
      set_flash_message(:notice, 'You are not authorized to view this page')
      redirect_to root_path
    end
  end

  def authenticate_uber!
    unless uber_signed_in?
      set_flash_message(:notice, 'You are not authorized to view this page')
      redirect_to root_path
    end
  end

  def authenticate_super!
    unless super_signed_in?
      set_flash_message(:notice, 'You are not authorized to view this page')
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      if resource.role == 'uber'
        system_path
      else
        moderator_path
      end
    else
      root_path
    end
  end

  def uber_signed_in?
    current_user&.uber?
  end

  def super_signed_in?
    current_user&.super? || uber_signed_in?
  end

  def mod_signed_in?
    super_signed_in? || uber_signed_in? || current_user&.mod?
  end

  def admin_signed_in?
    current_user&.admin
  end

  helper_method :mod_signed_in?
  helper_method :uber_signed_in?
  helper_method :admin_signed_in?

  def set_flash_message(kind, message)
    unless message.class == Array
      message = [message]
    end
    flash[kind] = message
  end
end
