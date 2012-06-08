
# displays the first and last name
class DetailViewController < UIViewController
  attr_accessor :playas_controller

  def initWithCharacter(character)
    @character = character
    init
  end

  def viewDidLoad
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor
    self.title = "#{@character[:first]} #{@character[:last]}"

    @first = UITextField.alloc.initWithFrame([[10, 30], [300, 40]])
    @first.borderStyle = UITextBorderStyleRoundedRect
    @first.text = @character[:first]
    @first.font = UIFont.systemFontOfSize(14)
    @first.minimumFontSize = 17
    @first.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    @first.adjustsFontSizeToFitWidth = true
    @first.placeholder = "First Name"
    @first.delegate = self
    self.view.addSubview(@first)

    @last = UITextField.alloc.initWithFrame([[10, 80], [300, 40]])
    @last.borderStyle = UITextBorderStyleRoundedRect
    @last.text = @character[:last]
    @last.font = UIFont.systemFontOfSize(14)
    @last.minimumFontSize = 17
    @last.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    @last.adjustsFontSizeToFitWidth = true
    @last.placeholder = "First Name"
    @last.delegate = self
    self.view.addSubview(@last)
  end

  def textFieldShouldReturn(text_field)
    if text_field == @first
      @last.becomeFirstResponder
    else
      @first.becomeFirstResponder
    end
  end

  def textFieldDidEndEditing(text_field)
    if text_field == @first
      @character[:first] = text_field.text
    else
      @character[:last] = text_field.text
    end

    @playas_controller.table.reloadData
  end

end
