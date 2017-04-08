require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  # insert entry alphabetically
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

    #array.insert(index,obj) - inserts the given object before the element with the given index
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

  # will return an object of type Entry
  def binary_search(name)
    # index of the leftmost entry in entries array is stored in variable lower
    lower = 0
    # index of the rightmost entry
    upper = entries.length - 1

    while lower <= upper
      # find middle index
      mid = (lower + upper) / 2
      # retrieve the name of the entry at the middle index and store it in mid_name
      mid_name = entries[mid].name

      # compare the 'name' we are searching for with the name stored in middle index, mid_name
      if name == mid_name
        return entries[mid]
      # If name is alphabetically before mid_name. Then loop through lower half of array
      elsif name < mid_name
        upper = mid - 1
      # If name is alphabetically after mid_name. Then loop throught upper half of array.
      elsif name > mid_name
        lower = mid + 1
      end
    end
    # match not found
    return nil
  end
end
