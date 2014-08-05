FactoryGirl.define do
	factory :user do
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		password { Faker::Internet.password(8, 20) }
		email { Faker::Internet.email }
		instrument { "drums" }
		state { Faker::Address.state }
		street { Faker::Address.street_name }
		city { Faker::Address.city }

		trait :has_personal_statement do
			statement "I love Jammer!"
		end

		trait :has_genres do
			genres "Rock,Classical,World"
		end

		trait :can_give_lessons do
			lessons true
		end

		trait :has_avatar do
			avatar { Faker::Internet.url }
		end

		factory :user_with_a_song do
			after(:create) do |user|
				user.songs << FactoryGirl.create(:song)
			end
		end

		factory :user_with_multiple_songs do
			after(:create) do |user|
				5.times do |index|
					user.songs << FactoryGirl.create(:song, song_name: "Big Song #{index + 1}", song_number: index + 1)
				end
			end
		end

		factory :user_with_three_songs do
			after(:create) do |user|
				3.times do |index|
					user.songs << FactoryGirl.create(:song, song_name: "My Song #{index + 1}", song_number: index + 1, url: "song#{index + 1}_url")
				end
			end
		end

		factory :invalid_user do
			first_name ""
		end
	end
end