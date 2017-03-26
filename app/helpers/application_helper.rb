module ApplicationHelper

  def day_beforize(time)

    return nil if !time
    if time.to_date === Date.today
      "Ma, #{time.strftime('%H:%M')}"
    elsif time.to_date === Date.today.advance(days: -1)
      "Tegnap, #{time.strftime('%H:%M')}"
    elsif time.to_date === Date.today.advance(days: -2)
      "Tegnapelőtt, #{time.strftime('%H:%M')}"
    elsif time.year == Time.now.year
      l time, format: :topiclist
    else
      l time
    end

  end
end
