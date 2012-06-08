def rgba_color(r, g, b, a=1)
  UIColor.colorWithRed((r/255.0), green:(g/255.0), blue:(b/255.0), alpha:a)
end


class MyApplicationController < UIViewController

  def viewDidLoad
    toolbar = UIToolbar.alloc.initWithFrame [[0, 416], [320, 44]]
    toolbar.tintColor = rgba_color(21, 78, 118)  # dark aqua blue?
    self.view.addSubview(toolbar)

    toolbar_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemRefresh,
        target: self,
        action: :flipp)

    toolbar.setItems([toolbar_button], animated:false)

    @current = left_view_controller
    self.view.insertSubview(@current.view, atIndex:0)
  end

  def left_view_controller
    @left_view_controller ||= LeftViewController.alloc.init
  end

  def right_view_controller
    @right_view_controller ||= RightViewController.alloc.init
  end

  def flipp
    UIView.beginAnimations("flipp", context:nil)
    UIView.setAnimationDuration(1.25)
    UIView.setAnimationCurve(UIViewAnimationCurveEaseInOut)

    remove = @current

    if @current == left_view_controller
      @current = right_view_controller
      # transition = UIViewAnimationTransitionFlipFromLeft
      transition = UIViewAnimationTransitionCurlUp
    else
      @current = left_view_controller
      # transition = UIViewAnimationTransitionFlipFromRight
      transition = UIViewAnimationTransitionCurlDown
    end

    UIView.setAnimationTransition(transition,
                  forView:self.view,
                  cache:true)

    remove.viewWillDisappear(true)
    @current.viewWillAppear(true)

    remove.view.removeFromSuperview
    self.view.insertSubview(@current.view, atIndex:0)

    remove.viewDidDisappear(true)
    @current.viewDidAppear(true)

    UIView.commitAnimations
  end

  def didReceiveMemoryWarning
    super

    if @current == left_view_controller
      @right_view_controller = nil
    else
      @left_view_controller = nil
    end
  end

end


class LeftViewController < UIViewController

  def viewDidLoad
    self.view.backgroundColor = rgba_color(0, 136, 14)
    self.view.frame = [[0, 0], [320, 460]]
  end

end


class RightViewController < UIViewController

  def viewDidLoad
    self.view.backgroundColor = rgba_color(16, 110, 255)
    self.view.frame = [[0, 0], [320, 460]]
  end

end
