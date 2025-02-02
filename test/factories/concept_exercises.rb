FactoryBot.define do
  factory :concept_exercise do
    track do
      Track.find_by(slug: :ruby) || build(:track, slug: 'ruby')
    end

    uuid { SecureRandom.uuid }
    slug { 'strings' }
    blurb { 'strings are super useful' }
    title { slug.to_s.titleize }
    icon_name { 'strings' }
    position { 1 }
    git_sha { "HEAD" }
    synced_to_git_sha { "HEAD" }

    trait :random_slug do
      slug { SecureRandom.hex }
    end
  end
end
