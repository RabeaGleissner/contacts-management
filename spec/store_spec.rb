require 'spec_helper'
require 'store'
require 'test_data'
require 'mock_file'
require 'mock_file_system'
require 'mock_converter'

describe Store do
  it "persists data in a file" do
    mock_file = MockFile.new
    store = Store.new(MockFileSystem.new(mock_file))
    store.persist("contact data")
    expect(mock_file.data).to eq "--- contact data\n...\n"
  end

  it "reads data from a file" do
    converter = MockConverter.new
    store = Store.new(MockFileSystem.new(nil), converter)
    store.read
    expect(converter.load_file_was_called).to be true
  end
end
