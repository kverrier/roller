class Video < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :youtube_id, :name

  validates_presence_of :end_time, :start_time, :youtube_id, :name

  default_scope order: 'created_at DESC'


  def start_str
    format_time(start_time)
  end

  def end_str
    format_time(end_time)
  end


  def format_time(total_seconds, options = {})
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / 3600

    if hours > 0
      "%d:%02d:%02d" % [hours, minutes, seconds]
    else
      "%d:%02d" % [minutes, seconds]
    end
  end

  # Helper method to parse a string like "1:03:56.555" and return the number of
  # milliseconds that time length represents.
  def parse_time(string)
    parts = string.split(":").map(&:to_f)
    parts = [0] + parts if parts.length == 2
    hours, minutes, seconds = parts
    seconds = hours * 3600 + minutes * 60 + seconds
    seconds.to_i
  end
end
