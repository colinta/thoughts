
class MyApplicationController < UIViewController

  def plist
    document('editable_tableview.plist')
  end

  def persist
    @players.writeToFile(plist, atomically:true)
  end

  def load_players
    if exists(plist)
      @players = NSArray.alloc.initWithContentsOfFile(plist)
    else
      @players = [
        {'first' => 'firsty', 'last' => 'McLasty'},
        {'first' => 'humphrey', 'last' => 'bogart'},
      ]
      self.persist
    end
  end

  def viewDidLoad
    puts "viewDidLoad"
    self.title = "Editable Tableview"

    self.load_players

    @table_view = UITableView.alloc.initWithFrame [[0, 0], [320, 480]], style: UITableViewStylePlain
    @table_view.dataSource = self
    @table_view.delegate = self

    self.parentViewController.delegate = self

    self.navigationItem.leftBarButtonItem = self.editButtonItem
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
        UIBarButtonSystemItemAdd,
        target: self,
        action: :addPlayer)

    view.addSubview(@table_view)
  end

  def viewWillAppear(animated)
    NSNotificationCenter.defaultCenter.addObserver(self,
        selector: "playersChanged",
        name: "players changed",
        object: nil)
  end

  def viewWillDisappear(animated)
    NSNotificationCenter.defaultCenter.removeObserver(self)
  end

  def tableView(tableView, cellForRowAtIndexPath:index_path)
    puts "tableView(#{tableView}, cellForRowAtIndexPath:#{index_path})"
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier) ||
          UITableViewCell.alloc.initWithStyle( UITableViewCellStyleDefault,
                              reuseIdentifier: cell_identifier)
    cell.textLabel.text = "#{@players[index_path.row]['first']} #{@players[index_path.row]['last']}"

    return cell
  end

  def cell_identifier
    @@cell_identifier ||= 'Cell'
  end

  def tableView(tableView, numberOfRowsInSection: section)
    puts "tableView(#{tableView}, numberOfRowsInSection: #{section})"
    case section
    when 0
      @players.length
    else
      0
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:index_path)
    puts "tableView(#{tableView}, didSelectRowAtIndexPath:#{index_path})"
    tableView.deselectRowAtIndexPath(index_path, animated:true)

    self.edit_player_controller.player = @players[index_path.row]

    self.parentViewController.delegate = self.edit_player_controller
    self.parentViewController.pushViewController(self.edit_player_controller, animated: true)
  end

  def edit_player_controller
    @edit_player_controller ||= EditPlayerController.new
  end

  def add_player_controller
    @add_player_controller ||= EditPlayerController.new.tap do |ctlr|
        ctlr.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
            UIBarButtonSystemItemCancel,
            target: self,
            action: :cancelAddPlayer)

        ctlr.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
            UIBarButtonSystemItemDone,
            target: self,
            action: :doneAddPlayer)

        ctlr.navigationItem.rightBarButtonItem.enabled = false
    end
  end

  def playersChanged
    puts "playersChanged"
    self.persist
    @table_view.reloadData
  end

  def addPlayer
    # assign the player (resets the inputs)
    self.add_player_controller.player = nil

    # create and customize the navigation controller.  This gives us an easy
    # place to put the "Cancel" and "Done" buttons, and a "New Player" title.
    ctlr = UINavigationController.alloc.initWithRootViewController(self.add_player_controller)
    ctlr.modalTransitionStyle = UIModalTransitionStyleCoverVertical
    ctlr.delegate = self

    self.presentViewController(ctlr, animated:true, completion:nil)
  end

  def cancelAddPlayer
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  def doneAddPlayer
    puts "added: #{self.add_player_controller.player}"
    if self.add_player_controller.player
      @players.push(self.add_player_controller.player)
      self.playersChanged
    end
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  def tableView(tableView, commitEditingStyle:editing_style, forRowAtIndexPath:index_path)
    if editing_style == UITableViewCellEditingStyleDelete
      editing_style = "UITableViewCellEditingStyleDelete"
      @players.delete_at(index_path.row)
      @table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation:UITableViewRowAnimationAutomatic)
      self.playersChanged
    end
    puts "tableView(#{tableView}, commitEditingStyle:#{editing_style}, forRowAtIndexPath:#{index_path})"
  end

  def tableView(tableView, moveRowAtIndexPath:from_index_path, toIndexPath:to_index_path)
    puts "tableView(#{tableView}, moveRowAtIndexPath:#{from_index_path}, toIndexPath:#{to_index_path})"
    move = @players.delete_at(from_index_path.row)
    if move
      @players.insert(to_index_path.row, move)
      self.playersChanged
    end
  end

  def setEditing(is_editing, animated:is_animated)
    puts "setEditing(#{is_editing}, animated:#{is_animated})"
    @table_view.setEditing(is_editing, animated:is_animated)
    super
  end

end