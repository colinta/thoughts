class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    UINavigationBar.appearance.setBackgroundImage(UIImage.imageNamed("table-bg"), forBarMetrics: UIBarMetricsDefault)
    UINavigationBar.appearance.tintColor = UIColor.colorWithRed(0.294117647059, green:0.0, blue:0.509803921569, alpha: 0)

    back_normal = UIImage.imageNamed("btn-back").resizableImageWithCapInsets([0, 14, 0, 6])
    back_highlighted = UIImage.imageNamed("btn-back-pressed").resizableImageWithCapInsets([0, 14, 0, 6])
    bar_button_normal = UIImage.imageNamed("btn-button").resizableImageWithCapInsets([0, 5.5, 0, 5.5])
    bar_button_highlighted = UIImage.imageNamed("btn-button-pressed").resizableImageWithCapInsets([0, 5.5, 0, 5.5])
    UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_normal, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    UIBarButtonItem.appearance.setBackButtonBackgroundImage(back_highlighted, forState: UIControlStateHighlighted, barMetrics: UIBarMetricsDefault)
    UIBarButtonItem.appearance.setBackgroundImage(bar_button_normal, forState: UIControlStateNormal, barMetrics: UIBarMetricsDefault)
    UIBarButtonItem.appearance.setBackgroundImage(bar_button_highlighted, forState: UIControlStateHighlighted, barMetrics: UIBarMetricsDefault)

    mine = MyApplicationController.alloc.init
    nav_ctlr = UINavigationController.alloc.initWithRootViewController(mine)

    @window.rootViewController = nav_ctlr

    true
  end

end


class Kernel

  def document(filename)
    @docs ||= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    @docs.stringByAppendingPathComponent(filename)
  end

  def exists(filename)
    NSFileManager.defaultManager.fileExistsAtPath(filename)
  end

end
