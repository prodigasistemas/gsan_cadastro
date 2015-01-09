module IncrementableId
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      before_create :increment_id
    end
  end

  module ClassMethods
  end

  private

  def increment_id
    self.id = (self.class.maximum(:id) || 0) + 1
  end
end
