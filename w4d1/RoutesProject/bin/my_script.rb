require 'addressable/uri'
require 'rest-client'

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3/contacts').to_s

# puts RestClient.patch(url, { user: { email: "gizmo@yahoo.com"  } })
puts RestClient.get(url)

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  begin
    puts RestClient.post(
      url,
      { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo"  } }
    )
  rescue RestClient::Exception => e
    puts e
  end
end
