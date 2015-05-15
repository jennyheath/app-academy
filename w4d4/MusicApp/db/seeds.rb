# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create!(email: "jenny@example.com", password: "password")
u2 = User.create!(email: "cameron@example.com", password: "password")

b1 = Band.create!(name: "West Rhetoric")
Album.create!(band_id: b1.id, title: "Morbid Trophies", recording_type: "STUDIO")
Album.create!(band_id: b1.id, title: "Thirsty", recording_type: "STUDIO")

b2 = Band.create!(name: "A Tribe Called Quest")
Album.create!(band_id: b2.id, title: "Midnight Marauders", recording_type: "STUDIO")
Album.create!(band_id: b2.id, title: "Beats Rhyms & Life", recording_type: "LIVE")

b3 = Band.create!(name: "Fugees")
Album.create!(band_id: b3.id, title: "The Score", recording_type: "LIVE")
Album.create!(band_id: b3.id, title: "Greatest Hits", recording_type: "LIVE")
