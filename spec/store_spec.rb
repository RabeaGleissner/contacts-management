require 'spec_helper'
require 'store'
require 'test_data'
require 'test_doubles/file_spy'
require 'test_doubles/fake_file_system'
require 'test_doubles/fake_parser'

describe Store do
  let(:file) { FileSpy.new}

  it "persists data as an array in yaml format" do
    file = FileSpy.new
    store = Store.new(FakeFileSystem.new(file))
    store.persist("test data")
    expect(file.data).to eq ["---\n- test data\n"]
  end

  it "reads data from a file" do
    store = Store.new(FakeFileSystem.new(file), FakeParser.new(file))
    store.persist("testing")
    expect(store.read_from_file).to eq ["testing"]
  end

  it "adds a contact to an existing contact" do
    store = Store.new(FakeFileSystem.new(file), FakeParser.new(file, [TestData::JON_DOE]))
    store.persist(TestData::JANE_MILLER)
    store.persist(TestData::JON_DOE)
    expect(store.read_from_file).to eq([TestData::JON_DOE, TestData::JANE_MILLER])
  end
end
