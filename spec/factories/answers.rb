FactoryBot.define do
  sequence :body do |n|
    "MyTextAnswer#{n}"
  end

  factory :answer do
    body "MyTextAnswer"
    question_id 1
    author
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    question_id nil
    author
  end

  factory :generate_answer, class: "Answer" do
    body { generate(:body) }
    question_id nil
    author
  end

end
