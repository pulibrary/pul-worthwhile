FactoryGirl.define do
  factory :scanned_book do
    title ["Test title"]
    source_metadata_identifier "1234567"
    access_policy "Do you want a jelly baby?"
    use_and_reproduction "Jamie, remind me to give you a lesson in tying knots, sometime."
    visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
  end
end		
