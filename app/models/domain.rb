class Domain < ApplicationRecord
  # Minted Subnames
  has_many :subnames, dependent: :destroy

  # Minting Configuration
  has_one :minting_config, dependent: :destroy

  # % calc_minting_fee :: string -> [boolean, int]
  # returns [mintable?, minting_fee]
  def calc_minting_fee(subname)
    reserved_subname = minting_config.reserved_subnames.find_by(subname: subname)
    if reserved_subname
      if reserved_subname.mintable
        return [true, reserved_subname.minting_price]
      else
        return [false, nil]
      end
    else
      base_price = minting_config.base_price
      length_price = minting_config.length_prices[subname.length] || 0
      type_price = get_type_price(subname)
      return [true, base_price + length_price + type_price]
    end
  end

  private

  def get_type_price(subname)
    case subname
    when /^[0-9]+$/
      minting_config.type_prices[:numbers_only] || 0
    when /^[🍎-🍏]+$/
      minting_config.type_prices[:emoji_only] || 0
    else
      0
    end
  end
end
