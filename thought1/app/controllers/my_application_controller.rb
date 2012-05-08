class MyApplicationController < UIViewController

  def viewDidLoad
    left = @left
    top = @top

    colors = {
      10 => UIColor.grayColor,
      20 => UIColor.blackColor,
      30 => UIColor.blueColor,
      40 => UIColor.greenColor,
    }
    @labels = []

    colors.keys.each {|size|
      height = size + 10
      label = UILabel.new  # calls alloc and init (?)
      label.font = UIFont.systemFontOfSize(size)
      device = ipad? ? 'iPad' : 'iPhone'
      label.text = "Label of size #{size} on #{device}"
      label.textColor = colors[size]
      label.frame = [[left, top], [view.frame.size.width - left * 2, height]]
      view.addSubview(label)
      top += height + 10
      @labels.push label
    }

    @label_index = 0
    @label = @labels[0]

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle('Do Something', forState:UIControlStateNormal)
    @button.addTarget(self, action:'actionTapped',
                            forControlEvents:UIControlEventTouchUpInside)
    @button.frame = [[left, top], [view.frame.size.width - left * 2, 40]]
    view.addSubview(@button)
  end

  def actionTapped
    @label.text = 'Good job!'
    @label_index = (@label_index + 1) % @labels.length
    @label = @labels[@label_index]
  end

end