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
    (SERVICES_SETTINGS.map { |k,v| k.to_s }).include?(request.path_parameters[:service])
  end
end
