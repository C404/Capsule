##
## apipie.rb
## Login : <lta@still>
## Started on  Sat Nov 17 12:28:42 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

Apipie.configure do |config|
  config.app_name = "Capsule"
  config.copyright = "&copy; 2012 CapsuleTeam"
  config.doc_base_url = "/apidoc"
  config.api_base_url = "/api"
  config.validate = false
  config.markup = Apipie::Markup::Markdown.new
  config.reload_controllers = true
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "**","*.rb")
  config.app_info = <<-DOC
    Capsule is a video micro-blogging platform. This page describes its API. Allowing capsule and third party developper to interact with the services it provides.
  DOC
end
