class MyApplicationController < UIViewController

  def viewDidLoad
    images = {
      ok: {
        up: UIImage.imageNamed('ok_up.png'),
        down: UIImage.imageNamed('ok_down.png'),
      },
      plus: {
        up: UIImage.imageNamed('plus_up.png'),
        down: UIImage.imageNamed('plus_down.png'),
      },
      minus: {
        up: UIImage.imageNamed('minus_up.png'),
        down: UIImage.imageNamed('minus_down.png'),
      },
    }

    @minus_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @minus_button.frame = [[134 - 51, 223], [51, 43]]
    @minus_button.setImage(images[:minus][:up], forState:UIControlStateNormal)
    @minus_button.setImage(images[:minus][:down], forState:UIControlStateHighlighted)

    @plus_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @plus_button.frame = [[134, 223], [51, 43]]
    @plus_button.setImage(images[:plus][:up], forState:UIControlStateNormal)
    @plus_button.setImage(images[:plus][:down], forState:UIControlStateHighlighted)

    @ok_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @ok_button.frame = [[134 + 51, 223], [51, 34]]
    @ok_button.setImage(images[:ok][:up], forState:UIControlStateNormal)
    @ok_button.setImage(images[:ok][:down], forState:UIControlStateHighlighted)

    view.backgroundColor = UIColor.grayColor
    view.addSubview(@plus_button)
    view.addSubview(@minus_button)
    view.addSubview(@ok_button)
  end

end
