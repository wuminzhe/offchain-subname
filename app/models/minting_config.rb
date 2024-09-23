class MintingConfig < ApplicationRecord
  belongs_to :domain
  has_many :reserved_subnames, dependent: :destroy

  # maps the length of the subname to the price
  #
  # % length_prices :: Hash<Integer, Integer>
  serialize :length_prices, Hash

  # maps the type of the subname to the price
  # type is one of: :numbers_only, :emoji_only
  #
  # % type_prices :: Hash<Symbol, Integer>
  serialize :type_prices, Hash

  validates :base_price, presence: true
end
