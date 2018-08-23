class Participant < ApplicationRecord
  belongs_to :deal
  belongs_to :assistant
  enum :role => [:lead, :interview, :show, :close]
  enum :status => [:preliminary, :active, :removed]
  attr_default :rate, 50
  
  before_create :infer_rate
  
  scope :leading, lambda { where :role => :lead }
  scope :interviewing, lambda { where :role => :interview }
  scope :showing, lambda { where :role => :show }
  scope :closing, lambda { where :role => :close }
  scope :chrono, lambda { order :role }
  
  def name
    "#{role} by #{assistant.name}"
  end
  
  def payout
    deal.rate_for(role) * deal.distributable_commission(rate) / deal.participants.where(:role => role).count + adjustment.to_d if deal.commission
  end
  
  def infer_rate
    self.rate = assistant.rate if assistant.rate.present?
  end
end
