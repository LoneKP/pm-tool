FactoryBot.define do
  factory :organization do
    name { "MyString" }
    harvest_account_id { 1 }
  end
  factory :model do
    
  end

	factory :user do
		first_name { "John" }
		last_name  { "Doe" }
		email { "john@doe.com" }
	end

end