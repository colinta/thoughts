class EditPlayerController < UIViewController

  def first_field
    @first ||= UITextField.alloc.initWithFrame([[10, 30], [300, 40]]).tap do |first|
      first.borderStyle = UITextBorderStyleRoundedRect
      first.font = UIFont.systemFontOfSize(14)
      first.minimumFontSize = 17
      first.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      first.adjustsFontSizeToFitWidth = true
      first.placeholder = "First Name"
      first.delegate = self
    end
  end

  def last_field
    @last ||= UITextField.alloc.initWithFrame([[10, 80], [300, 40]]).tap do |last|
      last.borderStyle = UITextBorderStyleRoundedRect
      last.font = UIFont.systemFontOfSize(14)
      last.minimumFontSize = 17
      last.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      last.adjustsFontSizeToFitWidth = true
      last.placeholder = "Last Name"
      last.delegate = self
    end
  end

  def viewDidLoad
    puts "viewDidLoad"
    # labels and textfields for the first and last names go here
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor

    self.view.addSubview(self.first_field)
    self.view.addSubview(self.last_field)
  end

  def player=(player)
    puts "player=#{player}"
    @player = player
    # we will be using this view to *add* a player, in which case player will be nil.
    if not player
      # assign empty or default values
      self.title = ""
      self.first_field.text = ""
      self.last_field.text = ""
    else
      # assign values from player
      self.title = "#{@player[:first]} #{@player[:last]}"
      self.first_field.text = @player[:first]
      self.last_field.text = @player[:last]
    end
  end

  def textFieldShouldReturn(text_field)
    puts "text_field(#{text_field})"
    if text_field == self.first_field
      self.last_field.becomeFirstResponder
    else
      self.first_field.becomeFirstResponder
    end
  end

  def textFieldDidEndEditing(text_field)
    puts "textFieldDidEndEditing(#{text_field})"
    if text_field == self.first_field
      @player[:first] = text_field.text
    else
      @player[:last] = text_field.text
    end
    NSNotificationCenter.defaultCenter.postNotificationName("players changed", object:self)
  end

end
