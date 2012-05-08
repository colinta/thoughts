class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    application.setStatusBarStyle(UIStatusBarStyleBlackTranslucent)

    if ipad?
      @window.rootViewController = MyIpadController.alloc.init
    else
      @window.rootViewController = MyIphoneController.alloc.init
    end

    true
  end

end

class Kernel

  def ipad?
    UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
  end

end


class UIView

  def all
    [
      [0, 0],
      [self.frame.size.width, self.frame.size.height]
    ]
  end

end
