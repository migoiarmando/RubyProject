# Seed file to populate database with initial data
# Creates the admin user as specified

puts "Seeding database..."

# Create admin user
admin = User.find_or_initialize_by(email: 'admin@gmail.com')
if admin.new_record?
  admin.username = 'admin'
  admin.password = 'Password123'
  admin.password_confirmation = 'Password123'
  admin.role = 'admin'
  admin.full_name = 'Admin User'
  admin.bio = 'Administrator account'
  admin.save!
  puts "✓ Admin user created: admin@gmail.com / Password123"
else
  puts "✓ Admin user already exists: admin@gmail.com"
end

puts "Seeding complete!"
