class ApplicationController < ActionController::Base
  before_action :basic_auth

  def index
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'nekonekomaru' && password == '8888'
    end
  end
end
