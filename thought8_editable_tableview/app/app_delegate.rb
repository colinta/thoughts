class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    mine = MyApplicationController.alloc.init
    nav_ctlr = UINavigationController.alloc.initWithRootViewController(mine)

    @window.rootViewController = nav_ctlr

    true
  end

end
