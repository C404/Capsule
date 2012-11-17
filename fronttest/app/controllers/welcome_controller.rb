class WelcomeController < ApplicationController
  before_filter :inject_html_document

  def index
  end

  private
  def inject_html_document
    render 'layouts/angular', layout: false if request.format == Mime::HTML
  end
end
