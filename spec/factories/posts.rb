FactoryGirl.define do 
  factory :post do 
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }

    factory :post_with_topics do 
      transient do 
        topics_count 5 
      end

      after(:create) do |post, evaluator| 
        create_list(:topic, evaluator.topics_count, posts: [post])
      end 
    end
  end
end