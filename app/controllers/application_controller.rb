class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :prepare_unobtrusive_flash
end
