module ItemsHelper

  def item_expired?(item)
    if item.finish_time
      item.finish_time - Time.now < 0
    end
  end

  # Function created by Shippy (https://gist.github.com/xxMShipmanxx/8732888)
  # Takes the time and calculates how long it has left before the time expires
  def time_to_natural_language(time_left)
    if time_left > 0
      time_left = time_left.round.to_i
   
      weeks = time_left / 604800
      time_left -= weeks * 604800
   
      days = time_left / 86400
      time_left -= days * 86400
     
      hours = time_left / 3600
      time_left -= hours * 3600
   
      minutes = time_left / 60
      time_left -= minutes * 60
   
      seconds = time_left
   
      weeks   = weeks.to_s
      days    = days.to_s
      hours   = hours.to_s
      minutes = minutes.to_s
      seconds = seconds.to_s
   
      if weeks.to_i > 0
        pluralize(weeks, 'week')
      elsif days.to_i > 0
        pluralize(days, 'day')
      elsif hours.to_i > 0
        pluralize(hours, 'hours') + ", " + pluralize(minutes, 'minute')
      else
        pluralize(minutes, 'minute') + ", " + pluralize(seconds, 'second')
      end

    else
      "No time"
    end
  end

  def datetime_to_natural_format(datetime)
    datetime.strftime('%e %b %Y %H:%m:%S%p')
  end

end
