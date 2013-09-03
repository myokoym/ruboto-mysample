class HelloSourceActivity
  def on_create(bundle)
    super
    set_title("Hello Source")
    self.content_view = view
  end

  private
  def view
    scroll_view do
      linear_layout(:orientation => :vertical) do
        text_view(:text => File.open(__FILE__).read,
                  :width => :match_parent,
                  :text_size => 13.0)
      end
    end
  end
end
