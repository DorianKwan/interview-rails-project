return if Rails.env.test?
class Quote
  SOURCES = [
    -> { Faker::Quote.matz },
    -> { Faker::Quote.famous_last_words },
  ] + Faker::TvShows.constants.map { |c| -> { "Faker::TvShows::#{c}".constantize.quote } }

  # Get a random quote from the faker library
  # @returns [String] - The quote
  def self.random
    SOURCES.sample.()
  rescue I18n::MissingTranslationData
    # Not all of the Faker::TvShows have a quote defined.
    # If this method invokes Faker::TvShows::ParksAndRec.quote for example,
    # it should just keep trying until it finds a show with a quote.
    random
  end
end
