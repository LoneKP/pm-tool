FactoryBot.define do
  factory :model do
    
  end

	factory :user do
		first_name { "John" }
		last_name  { "Doe" }
		email { "john@doe.com" }
	end

end