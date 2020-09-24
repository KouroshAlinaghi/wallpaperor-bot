module Helpers

  def get_unsplash_link(photo_url)
    "https://api.unsplash.com/photos/#{photo_url}\?client_id=#{ENV["UNSPLASH_TOKEN"]}"  
  end

  def self.get_unsplash_photo_path_and_caption(message)
    request_url = get_unsplash_link(photo_url = message.text.split("/").last)
    response_object = JSON.parse HTTParty.get(request_url).body
    photo_path = obj["urls"]["full"]
    caption = obj["width"] > obj["height"] ? "#Desktop" : "#Phone"
    caption += "\n📷 Photo By: [#{obj["user"]["name"]}](#{obj["user"]["links"]["html"]})"
    [photo_path, caption]
  end

  client = Pexels::Client.new(ENV["PEXELS_TOKEN"])
  def self.get_pexels_photo_path_and_caption(message)
    id = message.text.split("-").last.to_i
    obj = client.photos[id]
    photo_path = obj.src["original"]
    caption = obj.width > obj.height ? "#Desktop" : "#Phone"
    caption += "\n📷 Photo By: [#{obj.user.name}](#{obj.user.url})"
    [photo_path, caption]
  end
end

