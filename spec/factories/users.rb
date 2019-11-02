FactoryBot.define do
  factory :michael, class: User do
    name {'Michael Example'}
    email { 'michael@example.com' }
    password_digest { "<%= User.digest('password') %>" }
    admin { true }
    activated { true }
    activated_at { "<%= Time.zone.now %>" }
  end

  factory :archer, class: User do
    name { 'Sterling Archer' }
    email { 'duchess@example.gov' }
    password_digest { "User.digest('password')" }
    activated { true }
    activated_at { "Time.zone.now" }
  end

  factory :lana, class: User do
    name { 'Lana Kane' }
    email { 'hands@example.gov' }
    password_digest { "User.digest('password')" }
    activated { true }
    activated_at { "Time.zone.now" }
  end

  factory :malory, class: User do
    name  { "Malory Archer" }
    email { 'boss@example.gov' }
    password_digest { "User.digest('password')" }
    activated { true }
    activated_at { "Time.zone.now" }
  end

  factory :sequence_user, class: User do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user-#{n}@example.com" }
    password_digest { "User.digest('password')" }
    activated { true }
    activated_at { "Time.zone.now" }
  end
end
