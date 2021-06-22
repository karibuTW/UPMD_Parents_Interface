# == Schema Information
#
# Table name: helloasso_orders
#
#  id                 :bigint           not null, primary key
#  amount_discount    :decimal(, )
#  amount_total       :decimal(, )
#  amount_vat         :decimal(, )
#  confirmation       :integer          default("automatic")
#  date               :datetime
#  form_slug          :string           not null
#  year               :integer          default(2021), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discount_code_id   :bigint
#  helloasso_order_id :string
#  parent_id          :bigint
#
# Indexes
#
#  index_helloasso_orders_on_discount_code_id    (discount_code_id)
#  index_helloasso_orders_on_helloasso_order_id  (helloasso_order_id) UNIQUE
#  index_helloasso_orders_on_parent_id           (parent_id)
#
class HelloassoOrder < ApplicationRecord
  belongs_to :parent
  has_many :helloasso_order_items, dependent: :destroy
  has_many :helloasso_payments, dependent: :destroy
  belongs_to :discount_code, inverse_of: :helloasso_orders, optional: true
  validates :helloasso_order_id, uniqueness: true

  scope :current_year, -> { where form_slug: Setting.helloasso_current_form_id }

  enum confirmation: {
    automatic: 0,
    OK: 1,
    NO: 2
  }, _prefix: true

  def payment_method
    helloasso_payments.first.payment_means if helloasso_payments.first.present?
  end

  def attestation_url
    helloasso_payments.first.payment_receipt_url if helloasso_payments.first.present?
  end
end
