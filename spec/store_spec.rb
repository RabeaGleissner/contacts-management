require 'spec_helper'
require 'store'
require 'test_data'
require 'file_store_mocks/mock_file'
require 'file_store_mocks/mock_file_system'
require 'file_store_mocks/mock_parser'

describe Store do
  it "persists data as an array in yaml format" do
    mock_file = MockFile.new
    store = Store.new(MockFileSystem.new(mock_file))
    store.persist("test data")
    expect(mock_file.data).to eq ["---\n- test data\n"]
  end

  it "reads data from a file" do
    mock_file = MockFile.new
    converter = MockParser.new(mock_file)
    store = Store.new(MockFileSystem.new(mock_file), converter)
    store.persist("testing")
    expect(store.read_from_file).to eq ["testing"]
  end

  it "adds a contact to an existing contact" do
    mock_file = MockFile.new
    converter = MockParser.new(mock_file, [TestData::JON_DOE])
    store = Store.new(MockFileSystem.new(mock_file), converter)
    store.persist(TestData::JANE_MILLER)
    store.persist(TestData::JON_DOE)
    expect(store.read_from_file).to eq([TestData::JON_DOE, TestData::JANE_MILLER])
  end
end
