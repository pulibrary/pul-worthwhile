FactoryGirl.define do
  factory :scanned_book do
    title ["Test title"]
    source_metadata_identifier "abc123"
    access_policy "No access for you."
    use_and_reproduction "Have at it."
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end
end		
