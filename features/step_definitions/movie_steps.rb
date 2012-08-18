Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  movie = Movie.find_by_title(title)
  assert movie.director == director
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  pos1 = page.body.index(e1)
  pos2 = page.body.index(e2)

  assert pos1 != nil
  assert pos2 != nil
  assert pos1 < pos2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(',')

  ratings.each do |rating|
    if (uncheck != 'un')
      step %{I check "ratings_#{rating.strip}"}
    else
      step %{I uncheck "ratings_#{rating.strip}"}
    end
  end
end

Then /I should see all of the movies/ do
  tr_count = page.all("tbody tr").count
  db_count = Movie.all.count
  assert tr_count == db_count
end

Then /I should see none of the movies/ do
  tr_count = page.all("tbody tr").count
  assert tr_count == 0
end
