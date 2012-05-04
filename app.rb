require 'sinatra'

get '/hi' do
  "Hello World!"
end

class KillStreak
  attr_reader :current_kill_count
  attr_reader :last_kill_at
  attr_accessor :streak_threshold

  def initialize
    @current_kill_count = 0
    @last_kill_at = nil
    @streak_threshold = 5
  end

  def streak?
    @current_kill_count > @streak_threshold
  end

  def add_kill
    @current_kill_count += 1
    @last_kill_at = Time.now
  end
end