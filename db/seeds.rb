require "faker"
Book.destroy_all
Genre.destroy_all

NUMBER_OF_GENRES = 4
BOOKS_PER_GENRE = 25

NUMBER_OF_GENRES.times do
  genre = Genre.create(name: Faker::Book.genre)

  BOOKS_PER_GENRE.times do
    book = genre.books.create(
      title:     Faker::Book.title,
      author:    Faker::Book.author,
      publisher: Faker::Book.publisher,
      price:     rand(100..20_000)
    )
    #--> unsplash API ... comes back with a 600x600 image based on the book name and genre
    query = URI.encode_www_form_component([book.title, genre.name].join(","))

    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")

    book.image.attach(io:       downloaded_image,
                      filename: "m-#{[book.title, genre.name].join('-')}.jpg")

    sleep(0.5)
  end
end

logger.debug("Created #{Genre.count} Genres.")
logger.debug("Created #{Book.count} Books.")

# ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")
