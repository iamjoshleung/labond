FactoryGirl.define do 
  factory :topic do 
    name { Faker::Lorem.characters(10) }

    factory :topic_with_posts do 
      transient do 
        posts_count 5
      end

      after(:created) do |topic, evaluator| 
        create_list(:post, evaluator.posts_count, topics: [topic])
      end
    end
  end
end