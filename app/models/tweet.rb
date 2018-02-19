class Tweet < ActiveRecord::Base
  scope :relevant, -> {
    where("message LIKE '%coke%' OR message LIKE '%coca-cola%' OR message LIKE '%diet-cola%'")
  }

  scope :latest, -> {
    order(created_at: :desc, published: :desc)
  }

  scope :latest_relevant, -> {
    relevant.latest
  }

  scope :latest_by_sentiment, -> {
    latest_relevant.order(sentiment: :desc)
  }
end
