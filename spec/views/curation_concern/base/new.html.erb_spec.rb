require 'rails_helper'

describe 'curation_concern/scanned_books/new.html.erb', type: :view do
  input_ids = [
    'scanned_book_source_metadata_identifier',
    'scanned_book_portion_note',
    'scanned_book_description',
    'scanned_book_access_policy',
    'scanned_book_use_and_reproduction',
    'visibility_open',
    'visibility_registered',
    'visibility_embargo',
    'visibility_lease',
    'visibility_restricted'
  ]

  let(:curation_concern) { ScannedBook.new }

  before do
    render file: 'curation_concern/scanned_books/new', locals: { curation_concern: curation_concern } 
  end

  input_ids.each do |input_id|
    it "has field for #{input_id}"  do
      expect(rendered).to have_field (input_id)
    end
  end 
end