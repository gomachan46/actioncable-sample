# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class OtogeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "otoge_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def judge(judge)
    ActionCable.server.broadcast "otoge_channel", judge: judge
  end
end
