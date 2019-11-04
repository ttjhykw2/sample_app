FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence(5) }
    created_at 42.days.ago
    association :user, factory: :michael

    factory :orange do
      content "I just ate an orange!"
      created_at 10.minutes.ago
      association :user, factory: :michael
    end

    factory :tau_manifesto do
      content "Check out the @tauday site by @mhartl: http://tauday.com"
      created_at 3.years.ago
      association :user, factory: :michael
    end

    factory :cat_video do
      content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
      created_at 2.hours.ago
      association :user, factory: :michael
    end

    factory :most_recent do
      content "Writing a short test"
      created_at Time.zone.now
      association :user, factory: :michael
    end

    factory :ants do
      content "Oh, is that what you want? Because that's how you get ants!"
      created_at 2.years.ago
      association :user, factory: :archer
    end

    factory :zone do
      content "Danger zone!"
      created_at 3.days.ago
      association :user, factory: :archer
    end

    factory :tone do
      content "I'm sorry. Your words made sense, but your sarcastic tone did not."
      created_at 10.minutes.ago
      association :user, factory: :lana
    end

    factory :van do
      content "Dude, this van's, like, rolling probable cause."
      created_at 4.hours.ago
      association :user, factory: :lana
    end
  end
end
=begin
  factory :orange, class: Micropost do
    content { "I just ate an orange!" }
    created_at { "#{10.minutes.ago}" }
    association :user, factory: :michael
  end

  factory :tau_manifesto, class: Micropost do
    content { "Check out the @tauday site by @mhartl: http://tauday.com" }
    created_at { "#{3.years.ago}" }
    association :user, factory: :michael
  end

  factory :cat_video, class: Micropost do
    content { "Sad cats are sad: http://youtu.be/PKffm2ul4dk" }
    created_at { "#{2.hours.ago}" }
    association :user, factory: :michael
  end

  factory :most_recent, class: Micropost do
    content { "Writing a short test" }
    created_at { "#{Time.zone.now}" }
    association :user, factory: :michael
  end

  factory :sequence_micropost, class: Micropost do
    sequence(:name) { |n| "Micropost_#{n}" }
    content { "#{Faker::Lorem.sentence(5)}" }
    created_at { "#{42.days.ago}" }
    association :user, factory: :michael
  end

  factory :ants, class: Micropost do
    content { "Oh, is that what you want? Because that's how you get ants!" }
    created_at { "#{2.years.ago}" }
    association :user, factory: :archer
  end

  factory :zone, class: Micropost do
    content { "Danger zone!" }
    created_at { "#{3.days.ago}" }
    association :user, factory: :archer
  end

  factory :tone, class: Micropost do
    content { "I'm sorry. Your words made sense, but your sarcastic tone did not." }
    created_at { "#{10.minutes.ago}" }
    association :user, factory: :lana
  end

  factory :van, class: Micropost do
    content { "Dude, this van's, like, rolling probable cause." }
    created_at { "#{4.hours.ago}" }
    association :user, factory: :lana
  end
=end
