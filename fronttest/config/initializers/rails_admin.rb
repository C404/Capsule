RailsAdmin.config do |config|


  ################  Global configuration  ################
  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Cabled', 'Admin']

  config.current_user_method { current_admin_user }

  config.excluded_models = [ 'Library::Tree', 'Hire::Container' ]

  config.label_methods << :description # Default is [:name, :title]


  # ################  Models configuration  ################

  # #######################  Library  ######################

  # config.model Library::Category do
  # end

  # config.model Library::Item do
  #   parent Library::Category
  # end

  # ########################  Hire  ########################

  # config.model Hire::Event do    
  # end

  # config.model Hire::Truck do
  #   parent Hire::Event
  # end

  # config.model Hire::Flight do
  #   parent Hire::Truck
  # end

end
