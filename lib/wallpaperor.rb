require 'telegram/bot'
require 'httparty'
require 'json'
require 'pexels'
require_relative 'wallpaperor/helpers'

tg_token = ENV["TG_TOKEN"]

Telegram::Bot::Client.run(tg_token) do |bot|
  bot.listen do |msg|
    if msg.from && msg.from.id == ENV["MY_ID"]
      case msg.text
      when /^https:\/\/unsplash/
        photo_path = Helpers.get_unsplash_photo_path_and_caption(msg)[0]
        caption = Helpers.get_unsplash_photo_path_and_caption(msg)[1]
        send = true
      when /^https:\/\/www.pexels.com/
        photo_path = Helpers.get_pexels_photo_path_and_caption(msg)[0]
        caption = Helpers.get_pexels_photo_path_and_caption(msg)[1]
        send = true
      else
        bot.api.send_message(chat_id: msg.chat.id, text: "Invalid URL")
        send = false
      end
#      bot.api.send_document(chat_id: "@ilovecloudstorage", document: photo_path, caption: caption, parse_mode: "Markdown") if send
    end
  end
end
