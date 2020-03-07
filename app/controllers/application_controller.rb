class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #デバイス機能実行前にconfigure_permitted_parametersの実行をする。

  protected

  def after_sign_in_path_for(resource)
    top_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [
        :name, :gender, :birthday, :address_prefecture, :address_city, :introduction,
        :sound, :profile_image_id, :email, :status, { part_ids: [] }, { genre_ids: [] },
        artists_attributes: [:id, :name]
      ]
    )
    #sign_upの際に追加したカラムのデータ操作を許可。
  end
end