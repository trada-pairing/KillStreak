require 'spec_helper'
require 'rack/test'

describe "App" do
  #include Rack::Test::Methods
  #
  #def app
  #  @app ||= App
  #end
  #
  #before(:each) { Redis.new.flushall }
  #
  #it "should respond to /" do
  #  get '/'
  #
  #  last_response.should be_successful
  #end
end

describe KillStreak do
  its(:current_kill_count) { should be_zero }
  its(:last_kill_at) { should be_nil }
  its(:streak_threshold) { should == 5 }

  describe "#streak?" do
    it "should return true when the current kill count is greater than to the streak_threshold" do
      kill_streak = KillStreak.new
      kill_streak.streak_threshold = 2
      kill_streak.add_kill
      kill_streak.add_kill
      kill_streak.add_kill

      kill_streak.streak?.should == true
    end

    it "should return false when the current kill count is less than the streak_threshold" do
      kill_streak = KillStreak.new
      kill_streak.streak_threshold = 2
      kill_streak.add_kill

      kill_streak.streak?.should == false
    end
  end

  describe "#add_kill" do
    it "should increment the kill count" do
      kill_streak = KillStreak.new

      expect { kill_streak.add_kill }.to change{kill_streak.current_kill_count}.by(1)
    end

    it "should update the last kill time" do
      kill_streak = KillStreak.new

      expect { kill_streak.add_kill }.to change { kill_streak.last_kill_at }
    end
  end
end