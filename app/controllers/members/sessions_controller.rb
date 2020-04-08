# frozen_string_literal: true

class Members::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :set_sign_out_member, only: [:destroy]
  after_action :member_become_offline, only: [:destroy]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # ゲストユーザーログイン機能
  def guest_create
    self.resource = resource_class.find_by(email: ENV["GUEST_LOGIN_USER_PASSWORD"])
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def set_sign_out_member
    @offline_member = Member.where(id: current_member.id).first
  end

  def member_become_offline
    @offline_member.update!(online: false, online_at: DateTime.now)
  end
end
