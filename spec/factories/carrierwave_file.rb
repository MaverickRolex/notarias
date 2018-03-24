FactoryBot.define do
  factory :brand do
    name "My Brand"
    description "Foo"
    logo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'brands', 'logos', 'logo_image.jpg'), 'image/jpeg') }
  end
end 