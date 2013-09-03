require "ruboto/widget"
require "ruboto/util/toast"
require "mysample/hello_source_activity"
require "mysample/sub_activity"
require "mysample/brain_training_activity"
require "mysample/hit_and_blow_activity"

ruboto_import_widgets :Button, :LinearLayout, :TextView, :ScrollView

class MysampleActivity
  def on_create(bundle)
    super
    set_title("My samples")
    self.content_view = view
  rescue
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private
  def view
    linear_layout(:orientation => :vertical) do
      text_view(:text => "Take anything you would like.",
                :id => 42,
                :width => :match_parent,
                :gravity => :center,
                :text_size => 20.0)

      linear_layout(:orientation => :horizontal) do
        button(:text => "Hello, World!",
               :width => :match_parent,
               :layout => {:weight= => 1},
               :id => 43,
               :on_click_listener => proc { hello })

        button(:text => "source code",
               :width => :match_parent,
               :layout => {:weight= => 1},
               :id => 47,
               :on_click_listener => proc { hello_source })
      end

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

  def hello_source
    start_ruboto_activity(:class_name => HelloSourceActivity.name)
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
