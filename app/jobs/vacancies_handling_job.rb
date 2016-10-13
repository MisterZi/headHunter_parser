class VacanciesHandlingJob
  @queue = :simple

  require 'open-uri'

  def self.perform
    response = open("https://api.hh.ru/vacancies?text=ruby").read
    vacancies = JSON.parse(response)

    ids = []
    vacancies['items'].each do |elements|
      ids << elements['id']
    end

  end
end