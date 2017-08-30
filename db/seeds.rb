# Plutus::Asset.create(:name => "Accounts Receivable")
# Plutus::Asset.create(:name => "Cash")
# Plutus::Revenue.create(:name => "Sales Revenue")
# Plutus::Liability.create(:name => "Unearned Revenue")
# Plutus::Liability.create(:name => "Sales Tax Payable")


u = User.new
u.username = 'Admin'
u.email = 'admin@gmail.com'
u.password = 'admin123'
u.password_confirmation = 'admin123'
u.save!
