module Posts
  class DateManipulationService

    def self.call(time_with_zone)
      date = time_with_zone.to_date
      today_date = Date.today
      days_difference = today_date.mjd - date.mjd

      if days_difference == 0
        'TODAY'
      elsif days_difference == 1
        'YESTERDAY'
      elsif days_difference <= 6
        day_name = date.strftime("%A").upcase
        "LAST #{day_name}"
      else
        date.strftime("%-d %^B %Y")
      end
    end

  end
end
