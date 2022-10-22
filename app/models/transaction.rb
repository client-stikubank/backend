# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum subject: { sender: 0, receiver: 1 }

  belongs_to :sourceable, polymorphic: true
  belongs_to :transactable, polymorphic: true

  after_commit :update_balance!, on: :create

  private

  def update_balance!
    case subject
    when :sender
      transactable.update(balance: transactable.balance - sourceable.amount)
    when :receiver
      transactable.update(balance: transactable.balance + sourceable.amount)
    else
      errors.add(:base, I18n.t('errors.messages.wrong_transaction_subject'))
    end
  end
end
