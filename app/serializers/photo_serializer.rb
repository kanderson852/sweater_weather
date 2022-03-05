class PhotoSerializer

  def self.image(image, location)
        {
      "data": {
        "type": "image",
        "id": 'null',
        "attributes": {
          "image": {
            "location": location,
            "image_url": image[:urls][:full],
            "credit": {
              "source": "https://images.unsplash.com",
              "author": image[:user][:name]
            }
          }
        }
      }
    }
  end
end
