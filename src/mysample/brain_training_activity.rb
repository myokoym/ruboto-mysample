class BrainTrainingActivity
  def initialize
    @start_time = Time.now
    @count = 0
    @passed = 0
    @num1 = Random.rand(10)
    @num2 = Random.rand(10)
  end

  def on_create(bundle)
    super
    set_title("Brain Training")
    self.content_view = view
  end

  private
  def view
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
