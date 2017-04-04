require_relative 'entry'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    # create a variable to store the insertion index
    index = 0
    entries.each do |entry|
      # compare 'name' with the name of the current entry
      # if 'name' alphabetically proceeds 'entry.name' we've found the 'index' to insert at. otherwise increment index and continue comparing.
      if name < entry.name
        break
      end
      index+= 1
    end

    #insert new entry using calculated index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    #variable to hold entry to be deleted
    delete_entry = nil

    @entries.each do |entry|
      if entry.name == name && entry.phone_number == phone_number && entry.email == email
        delete_entry = entry
      end
    end
    @entries.delete(delete_entry)
  end

end
