module ApplicationHelper

  def day_beforize(time)

    return nil if !time
    if time.day === Date.today.day
      "Ma, #{time.strftime('%H:%M')}"
    elsif time.day === Date.today.advance(days: -1).day
      "Tegnap, #{time.strftime('%H:%M')}"
    elsif time.to_date.day === Date.today.advance(days: -2).day
      "Tegnapelőtt, #{time.strftime('%H:%M')}"
    elsif time.year == Time.now.year
      l time, format: :topiclist
    else
      l time
    end

  end
end
