# == Schema Information
#
# Table name: parents
#
#  id                     :bigint           not null, primary key
#  address                :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  full_name              :string
#  last_name              :string           not null
#  mailing_list           :boolean          default(TRUE), not null
#  nationalities          :string           default([]), is an Array
#  phone_number           :string
#  preferred_language     :integer          default("vi"), not null
#  public_comment         :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_parents_on_confirmation_token    (confirmation_token) UNIQUE
#  index_parents_on_email                 (email) UNIQUE
#  index_parents_on_reset_password_token  (reset_password_token) UNIQUE
#
class Parent < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  include ParentCsvGenerator
  validates_plausible_phone :phone_number # , presence: false , with: /\A\+\d+/

  phony_normalize :phone_number, normalize_when_valid: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :full_name, presence: true
  # validates :address, presence: true

  enum preferred_language: {
    vi: 0,
    fr: 1,
    en: 2
  }

  scope :nationalities_in_array, ->(nation) { where('? = ANY(nationalities)', nation) }

  has_one :secondary_parent, dependent: :destroy

  has_many :children, dependent: :destroy
  has_many :bus_services, dependent: :destroy
  has_many :helloasso_orders, dependent: :nullify
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :secondary_parent, reject_if: proc { |attributes|
    attributes.except(:preferred_language, :_destroy).values.all?(&:blank?)
  }, allow_destroy: true
  accepts_nested_attributes_for :bus_services, reject_if: :all_blank, allow_destroy: true

  def self.ransackable_scopes(_auth_object = nil)
    %i[new_bus_service_eq nationalities_in_array]
  end

  def current_bus_registration
    bus_services.find_by year: Setting.current_school_year_start
  end

  def previous_bus_registration
    bus_services.find_by(year: Setting.current_school_year_start - 1)
  end

  def has_current_bus_registration?
    !current_bus_registration.nil?
  end

  def has_previous_bus_registration?
    !previous_bus_registration.nil?
  end

  def renewed_bus_service?
    has_current_bus_registration? && has_previous_bus_registration?
  end

  def new_bus_service?
    has_current_bus_registration? && !has_previous_bus_registration?
  end

  def current_year_helloasso_orders
    helloasso_orders.current_year
  end

  def payment_date
    current_year_helloasso_orders.first&.date
  end
  def paid_member?
    !current_year_helloasso_orders.empty?
  end

  def donation_orders
    current_year_helloasso_orders.where('amount_total > 1110 OR amount_discount > 1110')
  end

  def donated?
    !donation_orders.empty?
  end

  def display_name
    full_name.present? ? "#{full_name} (#{email})" : email
  end

  def locale
    preferred_language
  end

  def current_year_helloasso_order
    helloasso_orders.where(year: Setting.current_school_year_start)
  end

  def donation_amount
    amount = 0
    donation_orders.each do |o|
      if o.amount_total > 1110
        amount += (o.amount_total - 1110)
      elsif o.amount_discount > 1110
        amount += (o.amount_discount - 1110)
      end
    end
    amount
  end

end
