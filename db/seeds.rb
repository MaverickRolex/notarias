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

def load_segments(segments_array, parent_segment = nil)
  segments_array.each do |segment_hash|
    puts "creating #{segment_hash["name"]} segment"
    child_segment = Segment.create(name: segment_hash["name"])
    parent_segment.children << child_segment if parent_segment
    
    if segment_hash["children"]
      load_segments(segment_hash["children"], child_segment)
    end
  end
end

load_segments(segments)

Candidacy.create([{name: 'Presidente'}, {name: 'Presidente Municipal'}, {name: 'Síndico'}])
PoliticalParty.create([
  { name: 'PVEM' },
  { name: 'PRI' },
  { name: 'PAN' },
  { name: 'PRD' },
  { name: 'Morena'},
  { name: 'PT' },
  { name: 'Movimiento Ciudadano' }
])

[{ names: ['PRD', 'PAN'], name: 'PRD/PAN' }].each do |coalition|
  puts "creating coalition #{coalition[:name]}"
  coalition_ids = coalition[:names].map do |political_party|
    PoliticalParty.find_by(name: political_party).id
  end
  political_party = PoliticalParty.new(name: coalition[:name], coalition: true)
  political_party.parties_ids = coalition_ids
  political_party.save!
end


