# we require the AddressBook
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # display the main menu options
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    #retrieve user input using 'gets'
    selection = gets.to_i

    # use case statement operator to determine the proper response to the user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"

        # terminate program. '0' signals the program is exiting without an error
        exit(0)

      # catch invalid input and prompt the user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  # view entries
  def view_all_entries
    # iterate through all entries in AddressBook using 'each'
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s

      #call 'entry_submenu' method
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  #create new entries
  def create_entry
    # clear the screen before displaying the create entry prompts
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # add a new entry to address_book using add_entry method.
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp

    # call search on address_book which will either return a match or nil
    match = address_book.binary_search(name)
    system "clear"

    # This expression evaluates to false if  search returns nil
    if match
      puts match.to_s
      #call helper method
      search_submenu(match)

    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # if file is empty send user back to main menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      # call the import_from_csv method on our address_book. It will in turn call the add_entry method that will add new entries.
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def entry_submenu(entry)
    #dislay the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # 'chomp' removes whitespace from the string gets returns
    # This is necessary because "m " or "m\n" won't match  "m"
    selection = gets.chomp

    case selection
      # when 'next', do nothing just return to view_all_entries
      when "n"

      when "d"
        delete_entry(entry)

      when "e"
        edit_entry(entry)
        entry_submenu(entry)

      #return user to main menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selction} is not a valid input"
        entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} had been deleted"
  end

  def edit_entry(entry)
    # #1 ask user to update fields
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    # set attributes on entry only if a valid attribute was read from user input in #1 above
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry: "
    puts entry
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu

    when "e"
      system "clear"
      edit_entry(entry)
      main_menu

    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end
end
