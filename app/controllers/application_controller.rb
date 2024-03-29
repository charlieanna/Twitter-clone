class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters,if: :devise_controller?
  before_filter :set_pubnub
  serialization_scope :view_context
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
  def set_pubnub
    @pubnub = Pubnub.new(
      :publish_key   => 'pub-75a3aad0-d9c8-4763-8838-9aae1226ed0c',
      :subscribe_key => 'sub-fdd15440-8939-11e1-aa2b-41374c390533',
      :secret_key    => "sec-NThiMGVkZTAtNjZjYS00NTMyLWE0ZDYtNjJjYmU2YTBkNzJj",
      :cipher_key    => nil,
      :ssl           => nil
    )
  end
end
