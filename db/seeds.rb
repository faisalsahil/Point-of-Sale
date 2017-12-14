# Plutus::Asset.create(:name => "Accounts Receivable")
# Plutus::Asset.create(:name => "Cash")
# Plutus::Revenue.create(:name => "Sales Revenue")
# Plutus::Liability.create(:name => "Unearned Revenue")
# Plutus::Liability.create(:name => "Sales Tax Payable")

roles =['Admin','Cashier']

roles.each do |role|
  Role.create!(name: role)
end

admin = User.new
admin.username = 'Admin'
admin.email = 'admin@gmail.com'
admin.password = 'admin123'
admin.password_confirmation = 'admin123'
admin.role_id = Role.find_by_name(AppConstants::ADMIN).id
admin.save!

cashier = User.new
cashier.username = 'Cashier'
cashier.email = 'cash@gmail.com'
cashier.password = 'admin123'
cashier.password_confirmation = 'admin123'
cashier.role_id = Role.find_by_name(AppConstants::CASHIER).id
cashier.save!

