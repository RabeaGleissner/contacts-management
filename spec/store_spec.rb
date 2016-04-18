require 'spec_helper'
require 'store'
require 'test_data'
require 'mock_file'
require 'mock_file_system'

describe Store do
  it "persists data in a yaml file" do
    mock_file = MockFile.new
    store = Store.new(MockFileSystem.new(mock_file))
    store.persist("contact data")
    expect(mock_file.data).to eq "--- contact data\n...\n"
  end
end
