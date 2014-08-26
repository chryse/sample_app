namespace :db do
		desc "Fill database with sample data"
		task populate: :environment do
				make_users
				make_microposts
				make_relationships
		end
end

def make_users
		admin = User.create!(name: "Jun Kim",
												email: "timeisonourside@gmail.com",
												password: "foobar",
												password_confirmation: "foobar",
												admin: true)

		second_user = User.create!(name: "Hyunjun Kim",
																email: "chryse7@gmail.com",
																password: "foobar",
																password_confirmation: "foobar")

		99.times do |n|
				name = Faker::Name.name
				email = "example-#{n+1}@railstutorial.org"
				password = "password"
				User.create!(name: name,
										email: email,
										password: password,
										password_confirmation: password)
		end
end

def make_microposts
		users = User.all(limit: 6)
		50.times do
				content = Faker::Lorem.sentence(5)
				users.each do |user|
						user.microposts.create!(content: content)
				end
		end
end

def make_relationships
		users = User.all
		user = users.first
		followed_users = users[2..50]
		followers = users[3..40]
		followed_users.each do |followed|
				user.follow!(followed)
		end
		followers.each do |follower|
				follower.follow!(user)
		end
end
