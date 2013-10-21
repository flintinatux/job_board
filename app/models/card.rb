class Card
  include ActiveModel::Model
  attr_accessor :number, :month, :year, :postal_code, :cvv

  validates :number, presence: true
  validates :month,  presence: true
  validates :year,   presence: true
  validates :postal_code, presence: true
  validates :cvv,    presence: true, length: { minimum: 3, maximum: 4 }

  validate  :expires_in_the_future

  def charge(amount)
    Braintree::Transaction.sale(
      amount: amount.to_s,
      credit_card: {
        number: number,
        cvv:    cvv,
        expiration_month: month,
        expiration_year:  year
      },
      billing: {
        postal_code: postal_code
      },
      options: {
        submit_for_settlement: true
      }
    )
  end

  private

    def expires_in_the_future
      return unless month.present? and year.present?
      if Date.new(year.to_i, month.to_i, 1) < Date.today.beginning_of_month
        errors.add :expires_at, "Please choose an expiration date in the future."
      end
    end
end
