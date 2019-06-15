class ApplicationController < ActionController::Base

  # ==============================devisegem設定==================================
  # deviseのストロングパラメーターを変更する為のメソッド
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:admin_name])
    # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end

  # sign_in後のリダイレクト先設定
  def after_sign_in_path_for(resource)
    admin_items_path
  end
  # sign_out後のリダイレクト先設定
  def after_sign_out_path_for(resource)
    root_path
  end
  # ============================================================================

end
