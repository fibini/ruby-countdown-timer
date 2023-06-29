require 'io/console'

class CountdownTimer
  def initialize
    @seconds = 30
    @running = false
    @timer_thread = nil
  end

  def start
    handle_input
  end

  def handle_input
    loop do
      char = STDIN.getch

      case char
      when 's' # Start timer
        start_timer unless @running
      when 'p' # Pause/resume timer
        toggle_timer
      when 'q' # Quit program
        quit_program
        break
      end
    end
  end

  def start_timer
    return if @running

    @running = true
    @timer_thread = Thread.new do
      while @seconds > 0
        sleep 1
        @seconds -= 1 unless @running == false
      end

      if @running
        @running = true
        puts "Time's up!"
      end
    end

    puts 'Timer started.'
  end

  def toggle_timer
    if @running
      @running = false
      puts "timer paused #{@seconds.round(2)} seconds."
    elsif @seconds > 0
      @running = true
      puts 'Timer resumed.'
    end
  end

  def quit_program
    if @running
      @running = false
      @timer_thread.join
    end

    puts 'Program exited.'
  end
end

# Usage
timer = CountdownTimer.new
timer.start

  