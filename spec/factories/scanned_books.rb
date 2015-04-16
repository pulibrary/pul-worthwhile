FactoryGirl.define do
  factory :scanned_book do
    title ["Test title"]
    source_metadata_id "abc123"
    access_policy "No access for you."
    use_and_reproduction "Have at it."
  end

end
