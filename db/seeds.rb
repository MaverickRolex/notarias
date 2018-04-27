# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TODO: move all the users creation to this file and iterate to create
permissions = YAML.load_file(File.join(Rails.root, "db", "permissions.yml"))
permissions.each do |roles_key, role_value|
  role_value.each do |users_key, users_array|
    users_array.each do |user_hash|
      current_user = User.create(user_hash)
      if roles_key == "common"
        current_user.roles << Role.common
      elsif roles_key == "admin"
        current_user.roles << Role.admin
      elsif roles_key == "super_admin"
        current_user.roles << Role.super_admin
      end
    end
  end
end

segments = YAML.load_file(File.join(Rails.root, "db", "segments.yml"))

Candidacy.create([{name: 'Diputado'}, {name: 'Diputado 2'}, {name: 'Diputado 3'}])
PoliticalParty.create([
  { name: 'Partido Verde' },
  { name: 'PRI' },
  { name: 'PAN' },
  { name: 'PRD' },
  { name: 'Morena'},
  { name: 'PT' },
  { name: 'Movimiento Ciudadano' }
])