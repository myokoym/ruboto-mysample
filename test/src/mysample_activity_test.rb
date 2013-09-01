activity Java::net.myokoym.android.ruboto.mysample.MysampleActivity

setup do |activity|
  start = Time.now
  loop do
    @text_view = activity.findViewById(42)
    break if @text_view || (Time.now - start > 60)
    sleep 1
  end
  assert @text_view
end

test('initial setup') do |activity|
  assert_equal 'Take anything you would like.', @text_view.text
end

test('hello button click') do |activity|
  button = activity.findViewById(43)
  button.performClick
end

test('sub activity button click') do |activity|
  button = activity.findViewById(44)
  button.performClick
end
