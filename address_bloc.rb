require_relative 'controllers/menu_controller'

# create a new MenuController when AddressBloc starts
menu = MenuController.new

#clear the command line
system "clear"
puts "Welcome to AddressBloc!"

# to display menu, call the main_menu method from menu_controller.rb
menu.main_menu
