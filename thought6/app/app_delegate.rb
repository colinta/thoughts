
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    mine = RootViewController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(mine)

    @window.makeKeyAndVisible

    true
  end
end
