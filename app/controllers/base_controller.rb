class BaseController < ApplicationController
  def page_param
    params[:page]
  end

  def per_page_param
    params[:per_page] || 20
  end
end
