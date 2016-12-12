# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class OtogeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "otoge_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def judge(data)
    ActionCable.server.broadcast "otoge_channel", result: result(data["judge"])
  end

  private

  def result(judge)
    {
        judge: judge,
        score: score(judge),
        continuous_combo: continuous_combo?(judge)
    }
  end

  def score(judge)
    case judge
      when "COOL"
        300
      when "GOOD"
        100
      when "BAD"
        0
      else
        0
    end
  end

  def continuous_combo?(judge)
    case judge
      when "COOL"
        true
      when "GOOD"
        true
      when "BAD"
        false
      else
        false
    end
  end
end
