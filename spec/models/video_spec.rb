require 'spec_helper'

describe Video do
  before { @video = Video.new(name: "Pig Noises", youtube_id: "mx7AQGaYGus", start_time: 450, end_time: 466 ) }

  subject { @video }

  it { should respond_to(:name) }
  it { should respond_to(:youtube_id) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }

  it { should be_valid }

  describe "when name is not present" do
    before { @video.name = " " }
    # it { should_not be_valid }
    after { @video.name = "Noises" }
  end

  describe "when youtube_id is not present" do
    before { @video.youtube_id = " " }
    it { should_not be_valid }
    after { @video.youtube_id = "mx7AQGaYGus" }
  end

  describe "when start_time is not present" do
    before { @video.start_time = " " }
    it { should_not be_valid }
    after
  end

  describe "when end_time is not present" do
    before { @video.end_time = " " }
    it { should_not be_valid }
  end

end