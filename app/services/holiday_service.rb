class HolidayService
  def next_holidays
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed =JSON.parse(response.body, symbolize_names: true)
    parsed
  end

  def holiday_names
    next_holidays[0..2].map {|holiday| holiday[:name]}
  end

  def holiday_dates
    next_holidays[0..2].map {|holiday| holiday[:date]}
  end
end