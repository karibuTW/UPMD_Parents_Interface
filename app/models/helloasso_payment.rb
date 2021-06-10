# == Schema Information
#
# Table name: helloasso_payments
#
#  id                   :bigint           not null, primary key
#  amount               :decimal(, )
#  amount_tip           :decimal(, )
#  cash_out_state       :integer          default("MoneyIn")
#  date                 :datetime
#  fiscal_receipt_url   :string
#  payment_means        :integer          default("None")
#  payment_receipt_url  :string
#  payment_type         :integer          default("OFFLINE")
#  state                :integer          default("Pending")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  helloasso_order_id   :bigint           not null
#  helloasso_payment_id :string
#
# Indexes
#
#  index_helloasso_payments_on_helloasso_order_id    (helloasso_order_id)
#  index_helloasso_payments_on_helloasso_payment_id  (helloasso_payment_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (helloasso_order_id => helloasso_orders.id)
#
class HelloassoPayment < ApplicationRecord
  belongs_to :helloasso_order

  enum payment_means: {
    None: 0,
    Card: 1,
    Sepa: 2,
    Check: 3
  }

  enum state: {
    Pending: 0, Authorized: 1, Refused: 2, Unknown: 3, Registered: 4, Error: 5, Refunded: 6, Refunding: 7, Waiting: 8,
    Canceled: 9, Contested: 10, WaitingBankValidation: 11, WaitingBankWithdraw: 12
  }, _prefix: true

  enum payment_type: {
    OFFLINE: 0,
    CREDIT: 1,
    DEBIT: 2
  }

  enum cash_out_state: {
    MoneyIn: 0,
    CantTransferReceiverFull: 1,
    Transfered: 2,
    Refunded: 3,
    Refunding: 4,
    WaitingForCashOutConfirmation: 5,
    CashedOut: 6,
    Unknown: 7,
    Contested: 8
  }, _prefix: true

  validates :helloasso_payment_id, uniqueness: true
end
