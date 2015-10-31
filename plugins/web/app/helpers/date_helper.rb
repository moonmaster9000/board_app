module DateHelper
  def wrap_date(d, content)
    "#{date(d)} #{content}"
  end

  def date(d, today: Date.today)
    if (d == today)
      ""
    elsif (d.year != today.year)
      "#{d.month}/#{d.day}/#{d.year}:"
    else
      "#{d.month}/#{d.day}:"
    end
  end
end
