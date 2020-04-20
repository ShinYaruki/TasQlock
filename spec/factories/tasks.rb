FactoryBot.define do

  factory :task do
    association :user
    association :tag
    date                  {"2020-02-02"}
    starttime             {"09:00"}
    finishtime            {"10:00"}
    title                 {"00000000"}
    description           {"test"}
    done                  {"false"}
    tag_id                {"1"}
    user_id               {"1"}
  end

end