require "ruboto/widget"
require "ruboto/util/toast"

ruboto_import_widgets :Button, :LinearLayout, :TextView

class MysampleActivity
  def on_create(bundle)
    super
    set_title("My samples")
    self.content_view = content_layout
  rescue
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private
  def content_layout
    linear_layout(:orientation => :vertical) do
      text_view(:text => "Take anything you would like.",
                :id => 42,
                :width => :match_parent,
                :gravity => :center,
                :text_size => 20.0)

      button(:text => "Hello, World!",
             :width => :match_parent,
             :id => 43,
             :on_click_listener => proc { hello })

      button(:text => "Sub Activity!",
             :width => :match_parent,
             :id => 44,
             :on_click_listener => proc { sub_activity })

      button(:text => "Brain Training!",
             :width => :match_parent,
             :id => 45,
             :on_click_listener => proc { brain_training })

      button(:text => "Hit and Blow!",
             :width => :match_parent,
             :id => 46,
             :on_click_listener => proc { hit_and_blow })
    end
  end

  def hello
    toast "Hello, World!"
  end

  def sub_activity
    start_ruboto_activity(:class_name => SubActivity.name)
  end

  def brain_training
    start_ruboto_activity(:class_name => BrainTrainingActivity.name)
  end

  def hit_and_blow
    start_ruboto_activity(:class_name => HitAndBlowActivity.name)
  end
end

class SubActivity
  def on_create(bundle)
    super
    set_title("Sub Activity")
    self.content_view = content_layout
  end

  private
  def content_layout
    linear_layout(:orientation => :vertical) do
      button(:text => "finish!",
             :on_click_listener => proc { self.finish })
    end
  end
end

class BrainTrainingActivity
  def on_create(bundle)
    super
    set_title("Brain Training")
    self.content_view = content_layout
  end

  private
  def content_layout
    @start_time = Time.now
    @count = 0
    @passed = 0
    @num1 = Random.rand(10)
    @num2 = Random.rand(10)
    linear_layout(:orientation => :vertical) do
      @problem_view = text_view(:text => "#{@num1} < #{@num2}",
                                :width => :match_parent,
                                :gravity => :center,
                                :text_size => 60.0)

      @result_view = text_view(:text => "#{@passed} / #{@count}",
                               :width => :match_parent,
                               :gravity => :center,
                               :text_size => 40.0)

      @percentage_view = text_view(:text => "0%",
                                   :width => :match_parent,
                                   :gravity => :center,
                                   :text_size => 20.0)

      @time_view = text_view(:text => "0 sec/ans",
                             :width => :match_parent,
                             :gravity => :center,
                             :text_size => 20.0)

      linear_layout(:orientation => :horizontal,
                    :layout => {:width= => :match_parent,
                                :height= => :match_parent}) do
        button(:text => "YES",
               :height => :match_parent,
               :layout => {:weight= => 1},
               :text_size => 40.0,
               :on_click_listener => proc { check(true) })

        button(:text => "NO",
               :height => :match_parent,
               :layout => {:weight= => 1},
               :text_size => 40.0,
               :on_click_listener => proc { check(false) })
      end
    end
  end

  def check(bool)
    @count += 1
    sec_by_ans = (Time.now - @start_time) / @count
    @time_view.text = "#{sprintf("%.3f", sec_by_ans)} sec/ans"
    if (@num1 < @num2) == bool
      @passed += 1
    end
    @percentage_view.text = "#{"%3d" % (100.0 * @passed / @count)} %"
    @result_view.text = "#{@passed} / #{@count}"
    @num1 = Random.rand(10)
    @num2 = Random.rand(10)
    @problem_view.text = "#{@num1} < #{@num2}"
  end
end

class HitAndBlowActivity
  def on_create(bundle)
    super
    set_title("Hit and Blow")
    self.content_view = content_layout
  end

  private
  def content_layout
    @digit = 4
    @answer = (0..9).to_a.sample(@digit).join
    @reply = Array.new(@digit) { "0" }
    @num_views = []
    @trial = 0
    linear_layout(:orientation => :vertical) do
      @hit_view = text_view(:text => "Hit: ?",
                            :width => :match_parent,
                            :gravity => :center,
                            :text_size => 60.0)

      @blow_view = text_view(:text => "Blow: ?",
                             :width => :match_parent,
                             :gravity => :center,
                             :text_size => 50.0)

      @trial_view = text_view(:text => "trial: #{@trial}",
                              :width => :match_parent,
                              :gravity => :center,
                              :text_size => 30.0)

      linear_layout(:orientation => :horizontal,
                    :layout => {:width= => :match_parent,
                                :height= => :match_parent}) do
        (0...@digit).each do |i|
          linear_layout(:orientation => :vertical,
                        :width => :match_parent,
                        :layout => {:width= => :match_parent,
                                    :height= => :match_parent,
                                    :weight= => 1}) do
            button(:text => "+",
                   :height => :match_parent,
                   :layout => {:weight= => 1},
                   :text_size => 40.0,
                   :on_click_listener => proc { up(i) })

            @num_views[i] = text_view(:text => @reply[i],
                                      :height => :match_parent,
                                      :layout => {:weight= => 1},
                                      :gravity => :center,
                                      :text_size => 40.0)

            button(:text => "-",
                   :height => :match_parent,
                   :layout => {:weight= => 1},
                   :text_size => 40.0,
                   :on_click_listener => proc { down(i) })
          end
        end

        button(:text => "GO",
               :width => :match_parent,
               :height => :match_parent,
               :layout => {:weight= => 1},
               :text_size => 40.0,
               :on_click_listener => proc { check })
      end
    end
  end

  def up(i)
    @reply[i] = ((@reply[i].to_i + 1) % 10).to_s
    @num_views[i].text = @reply[i]
  end

  def down(i)
    @reply[i] = ((@reply[i].to_i + 10 - 1) % 10).to_s
    @num_views[i].text = @reply[i]
  end

  def check
    @trial += 1
    @trial_view.text = "trial: #{@trial}"
    hit  = count {|i| @answer[i] == @reply[i] }
    blow = count {|i| @answer.include?(@reply[i]) } - hit
    @hit_view.text = "Hit: #{hit}"
    @blow_view.text = "Blow: #{blow}"
    if hit == @digit
      toast "You did it!"
    end
  end

  def count
    (0...@digit).inject(0) {|sum, i| sum + (yield(i) ? 1 : 0) }
  end
end
