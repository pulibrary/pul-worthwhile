Worthwhile.configure do |config|
  # Injected via `rails g worthwhile:work ScannedBook`
  config.register_curation_concern :scanned_book
  config.register_curation_concern 'GenericWork'
end
