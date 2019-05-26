FactoryBot.define do
  factory :asana_integration do
    
  end
  factory :invitation do
    token { "MyString" }
    email { "MyString" }
  end
  factory :organisation do
    name { 'MyString' }
    harvest_account_id { 1 }
  end
  factory :model do
  end

  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john@doe.com' }
  end
end
