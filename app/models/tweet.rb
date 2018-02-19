class Tweet < ActiveRecord::Base
  scope :latest, -> {
    limit(10).order(created_at: :desc, published: :desc)
  }
end
