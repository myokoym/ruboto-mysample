require "ruboto/widget"
require "ruboto/util/toast"

ruboto_import_widgets :Button, :LinearLayout, :TextView

# http://xkcd.com/378/

class MysampleActivity
  def onCreate(bundle)
    super
    set_title("My samples")

    self.content_view =
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
        end
  rescue
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  private
  def hello
    toast "Hello, World!"
  end
end
