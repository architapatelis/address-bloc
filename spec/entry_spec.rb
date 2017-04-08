# to load our entry model for testing
require_relative '../models/entry'

# We are saying that the file is a spec file and that it tests the class Entry, found in entry.rb
RSpec.describe Entry do
  # initializer test (Entry attributes).
  describe "attributes" do
    # using 'let' set variable 'entry' equal to content of '{}'
    #'entry' is instance of class Entry
    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }
    # Each it represents a unique test.
    # 'expect' used to declare the expectations for the test. If those expectations are met, our test passes, if they are not, it fails.
    it "responds to name" do
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone_number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  # to_s test. # in front of to_s indicates it's an instance method
  describe "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"

      expect(entry.to_s).to eq(expected_string)
    end
  end

end
