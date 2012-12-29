module VideosHelper
  def youtube_embed_html(video_id, start_time, end_time)
    content_tag(:iframe, :src => "http://www.youtube.com/embed/#{video_id}?start=#{start_time}&end=#{end_time}".html_safe,
                :width => "480", :height => "270", :frameborder => "0") do
    end
  end

  def youtube_hidden_embed_html(youtube_id, start_time, end_time)
    content_tag(:iframe, :src => "http://www.youtube.com/embed/#{youtube_id}?start=#{start_time}&end=#{end_time}&autoplay=1&autohide=2&controls=0&showinfo=0".html_safe,
                :width => "640", :height => "360", :frameborder => "0") do
    end
  end

end
