class HitAndBlowActivity
  def initialize
    @digit = 4
    @answer = (0..9).to_a.sample(@digit).join
    @reply = Array.new(@digit) { "0" }
    @num_views = []
    @trial = 0
  end

  def on_create(bundle)
    super
    set_title("Hit and Blow")
    self.content_view = view
  end

  private
  def view
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
