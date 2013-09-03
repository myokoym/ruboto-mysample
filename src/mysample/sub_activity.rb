class SubActivity
  def on_create(bundle)
    super
    set_title("Sub Activity")
    self.content_view = view
  end

  private
  def view
    linear_layout(:orientation => :vertical) do
      button(:text => "finish!",
             :on_click_listener => proc { self.finish })
    end
  end
end
