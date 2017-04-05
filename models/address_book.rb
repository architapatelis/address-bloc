require_relative 'entry'
require "csv"

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


  def import_from_csv(file_name)
    #start by reading the file
    csv_text = File.read(file_name)
    #CSV.parse results in an object of type CSV::Table
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    #iterate over CSV::Table object rows
    csv.each do |row|
      #convert each table row to hash (key/value)
      row_hash = row.to_hash
      # convert each row_hash to Entry in AddressBook
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end
end
