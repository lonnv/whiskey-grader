
50.times do
  ReviewForm.new(
    title: FFaker::Book.title,
    description: FFaker::HipsterIpsum.sentences,
    taste_grade: rand(1..5),
    color_grade: rand(1..5),
    smokiness_grade: rand(1..5)
  ).submit
end