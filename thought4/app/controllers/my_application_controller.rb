def rgba_color(r, g, b, a=1)
  UIColor.colorWithRed((r/255.0), green:(g/255.0), blue:(b/255.0), alpha:a)
end


class MyApplicationController < UIViewController

  def viewDidLoad
    font = UIFont.fontWithName('DS-Digital', size:20)
    color = rgba_color(255, 255, 255)

    @label = UILabel.new
    @label.font = font
    @label.textColor = color
    @label.text = 'DS-Digital font'
    @label.frame = [[0, 0], [self.width, self.height]]
    @label.lineBreakMode = UILineBreakModeWordWrap
    @label.numberOfLines = 0
    @label.setBackgroundColor(UIColor.clearColor);

    shadow_color = rgba_color(200, 200, 255)
    @label.layer.shadowColor = shadow_color.CGColor;
    @label.layer.shadowOffset = [2, 2];
    @label.layer.shadowRadius = 2.0;
    @label.layer.shadowOpacity = 1.0;
    @label.layer.masksToBounds = false;
    @label.sizeToFit

    view.addSubview(@label)

    @button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @button.setTitle('Do Something', forState:UIControlStateNormal)
    @button.addTarget(self, action: :resetLabel,
                            forControlEvents:UIControlEventTouchUpInside)
    size = CGSizeMake(120, 35)
    point = CGPointMake(self.width - self.margin_right - size.width, self.height - self.margin_bottom - size.height)
    @button.frame = [point, size]
    view.addSubview(@button)

    view.backgroundColor = UIColor.blackColor
  end

  def shouldAutorotateToInterfaceOrientation(orientation)
    true if ipad? or orientation != UIInterfaceOrientationPortraitUpsideDown
  end

  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    button_size = @button.frame.size  # we will be moving the button, and use its
                                      # width and height as offsets
    button_offset = nil  # this will hold our "starting" point

    case orientation
    when UIInterfaceOrientationPortrait, UIInterfaceOrientationPortraitUpsideDown
      append = if orientation == UIInterfaceOrientationPortrait
                 'Upright'
               else
                 'UpsideDown'
               end
      label_size = [self.width, self.height]
      button_offset = CGPointMake(self.width, self.height)
    when UIInterfaceOrientationLandscapeLeft, UIInterfaceOrientationLandscapeRight
      append = if orientation == UIInterfaceOrientationLandscapeLeft
                 'Left'
               else
                 'Right'
               end
      label_size = [self.height, self.width]
      button_offset = CGPointMake(self.height, self.width)
    end

    puts "button_offset: #{button_offset}, button_size: #{button_size}"
    @button.frame = [[button_offset.x - self.margin_right - button_size.width, button_offset.y - self.margin_bottom - button_size.height], button_size]

    @label.text += ", #{append}"
    # resize - first, we need to set the maximum width and height again
    @label.frame = [[0, 0], label_size]
    # and then we can "sizeToFit"
    @label.sizeToFit
  end

  def resetLabel
    @label.text = 'DS-Digital font'
    @label.sizeToFit
  end

end


class MyIphoneController < MyApplicationController
  def width
    320
  end
  def height
    480
  end
  def margin_bottom
    20
  end
  def margin_right
    10
  end
end

class MyIpadController < MyApplicationController
  def width
    768
  end
  def height
    1024
  end
  def margin_bottom
    60
  end
  def margin_right
    20
  end
end
