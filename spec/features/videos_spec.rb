require 'spec_helper'


feature "site navigation" do
  
  it "should be able to navigate from home to videos and back" do
  	visit root_path
  	click_link('All Videos')
    current_path.should eq videos_path
    click_link('Home')
    current_path.should == root_path
  end

  it "test javascript", :js => true do
    visit root_path



    fill_in 'youtube_url', :with => 'http://www.youtube.com/watch?v=23OR-m4PI_Q'
    click_button 'Load Video'

    page.execute_script("$('#slider-range').slider('values', [72,80])")

    find_by_id('video_youtube_id').value.should == '23OR-m4PI_Q'
    find_by_id('video_start_time').value.should == 72
    find_by_id('video_end_time').value.should == 80

    # click 'Submit'
  end


end



