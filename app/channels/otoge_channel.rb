# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class OtogeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{uuid}_channel"
    stream_from "otoge_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def init
    ActionCable.server.broadcast "otoge_channel", init: uuid
  end

  def judge(data)
    ActionCable.server.broadcast "otoge_channel", result: result(data["judge"])
  end

  def start
    ActionCable.server.broadcast "otoge_channel", start: uuid
  end

  def finish(data)
    ActionCable.server.broadcast(
      "#{uuid}_channel",
      finish: {
        uuid: uuid,
        result: data["my_score"] > data["rival_score"] ? "win!" : "lose..."
      }
    )
  end

  private

  def result(judge)
    {
        uuid: uuid,
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
      else
        false
    end
  end
end
