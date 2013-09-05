# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




(1...100).each do |i|
  cat = Category.find_by_youtube_id( i )
  next if cat.present?

  url           = "https://www.googleapis.com/youtube/v3/videoCategories?part=id%2Csnippet&id=#{i}&key=#{ENV['YOUTUBE_API']}"
  response      = YoutubeApi.v3_authorized_request( url, nil )

  next unless response.response.code.to_i == 200 && response.parsed_response["items"].present?
  
  Category.create(
    :youtube_id => response.parsed_response["items"].dig(0, "id"),
    :title      => response.parsed_response["items"].dig(0, "snippet", "title")
  )

end