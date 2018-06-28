FactoryBot.define do
  factory :post do
    title "MyString"
    content "MyText [link](http://google.com)"
    user
  end
end
