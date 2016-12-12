# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SampleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "sample_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def hoge(judge)
    ActionCable.server.broadcast "sample_channel", judge: judge
  end
end
