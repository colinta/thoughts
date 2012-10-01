include SugarCube::Adjust


class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    ctlr = UINavigationController.alloc.initWithRootViewController(FirstController.new)
    @window.rootViewController = ctlr

    app_id = "5068639ebe790e1d9e000002"
    Crittercism.initWithAppID(app_id, andMainViewController:ctlr)
    @window.makeKeyAndVisible
    true
  end
end


class FirstController < UIViewController

  def viewDidLoad
    self.view.backgroundColor = :table_view.uicolor

    crash_button = UIButton.rounded
    crash_button.frame = [[0, 0], [132, 20]]
    crash_button.center = [self.view.frame.size.width/2.0, self.view.frame.size.height/2.0]
    crash_button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth
    crash_button.setTitle("Make my day.", forState: :normal.uicontrolstate)
    crash_button.on :touch do
      Crittercism.leaveBreadcrumb("User pressed the crash_button")
      raise "ZOMG!!"
    end
    self.view << crash_button

    feedback_button = UIButton.rounded
    feedback_button.frame = [[0, 0], [132, 20]]
    feedback_button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth
    center = crash_button.center
    center.y += 40
    feedback_button.center = center
    feedback_button.setTitle("Uh, this is stupid.", forState: :normal.uicontrolstate)
    feedback_button.on :touch do
      Crittercism.leaveBreadcrumb("User pressed the feedback_button")
      Crittercism.showCrittercism(self)
    end
    self.view << feedback_button
  end

end
