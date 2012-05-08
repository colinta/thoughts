class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.grayColor
    @window.makeKeyAndVisible

    application.setStatusBarStyle(UIStatusBarStyleBlackTranslucent)

    if ipad?
      @window.rootViewController = MyIpadController.alloc.init
    else
      @window.rootViewController = MyIphoneController.alloc.init
    end

    @window.rootViewController.wantsFullScreenLayout = true

    true
  end

end

class Kernel

  def ipad?
    UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
  end

end
