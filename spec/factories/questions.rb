FactoryBot.define do
  sequence :title do |n|
    "MyString#{n}"
  end
  
  factory :question do
    title "MyString"
    body "MyTextQuestion"
    author
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
    author
  end

  factory :generate_question, class: "Question" do
    title { generate(:title) }
    body "MyTextQuestion"
    author
  end
end
