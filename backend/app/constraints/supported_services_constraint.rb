##
## supported_services_contraint.rb
## Login : <lta@still>
## Started on  Sat Nov 17 14:25:35 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class SupportedServicesConstraint
  def self.matches?(request)
    supported_services = ['facebook', 'twitter', 'dailymotion', 'youtube']
    supported_services.include?(request.path_parameters[:service])
  end
end
