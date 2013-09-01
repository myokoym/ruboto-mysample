require "ruboto/widget"
require "ruboto/util/toast"

ruboto_import_widgets :Button, :LinearLayout, :TextView

class MysampleActivity
  def onCreate(bundle)
    super
    set_title("My samples")
    self.content_view = top_layout
  rescue
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private
  def top_layout
    linear_layout(:orientation => :vertical) do
      @text_view = text_view(:text => "Take anything you would like.",
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
    end
  end

  def hello
    toast "Hello, World!"
  end

  def sub_activity
    start_ruboto_activity(:class_name => "SubActivity")
  end
end

class SubActivity
  def onCreate(bundle)
    super
    set_title("Sub Activity")
    self.content_view = top_layout
  end

  private
  def top_layout
    linear_layout(:orientation => :vertical) do
      button(:text => "finish!",
             :on_click_listener => proc { self.finish })
    end
  end
end
