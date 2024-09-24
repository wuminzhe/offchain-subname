# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Domain.destroy_all
Subname.destroy_all
Address.destroy_all
MintingConfig.destroy_all

# Create domains
domains = [
  { name: 'example.eth', description: 'Example domain' },
  { name: 'test.eth', description: 'Test domain' },
  { name: 'mywebsite.eth', description: 'My personal website' }
]

domains.each do |domain_data|
  domain = Domain.create!(domain_data)
  
  # Create minting configs for each domain
  MintingConfig.create!(
    domain: domain,
    base_price: 0.01, # in ETH
    length_prices: { 1 => 0.1, 2 => 0.05, 3 => 0.02, 4 => 0.01 },
    type_prices: { numbers_only: 0.02, emoji_only: 0.03 },
    free_minting: false,
    reserved_subnames: ['admin', 'support', 'contact']
  )
end

# Create subnames
subnames = [
  { name: 'www', domain: Domain.find_by(name: 'example.eth') },
  { name: 'blog', domain: Domain.find_by(name: 'test.eth') },
  { name: 'shop', domain: Domain.find_by(name: 'mywebsite.eth') },
  { name: '123', domain: Domain.find_by(name: 'example.eth') },
  { name: 'abc', domain: Domain.find_by(name: 'test.eth') },
  { name: '😊', domain: Domain.find_by(name: 'mywebsite.eth') }
]

subnames.each do |subname|
  subname_record = Subname.create!(subname)
  puts "Minting fee for subname '#{subname_record.name}': #{subname_record.minting_fee} ETH"
end

# Create addresses
addresses = [
  { address: '1ExampleAddress', coin_type: 1, subname: Subname.find_by(name: 'www') },
  { address: '1TestAddress', coin_type: 2, subname: Subname.find_by(name: 'blog') },
  { address: '1MyWebsiteAddress', coin_type: 3, subname: Subname.find_by(name: 'shop') }
]

addresses.each do |address|
  Address.create!(address)
end

puts "Seeded #{Domain.count} domains, #{Subname.count} subnames, and #{Address.count} addresses."
