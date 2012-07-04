class MyApplicationController < UIViewController

  def viewDidLoad
    puts "viewDidLoad"
    self.title = "Editable Tableview"

    @players = [
      {first: 'firsty', last: 'McLasty'},
      {first: 'humphrey', last: 'bogart'},
    ]

    @table_view = UITableView.alloc.initWithFrame [[0, 0], [320, 480]], style: UITableViewStylePlain
    @table_view.dataSource = self
    @table_view.delegate = self
    self.navigationItem.leftBarButtonItem = self.editButtonItem
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
        UIBarButtonSystemItemAdd,
        target: self,
        action: :addPlayer)
    NSNotificationCenter.defaultCenter.addObserver(self,
        selector: "playersChanged",
        name: "players changed",
        object: nil)
    view.addSubview(@table_view)
  end

  def tableView(tableView, cellForRowAtIndexPath:index_path)
    puts "tableView(#{tableView}, cellForRowAtIndexPath:#{index_path})"
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier) ||
          UITableViewCell.alloc.initWithStyle( UITableViewCellStyleDefault,
                              reuseIdentifier: cell_identifier)
    cell.textLabel.text = "#{@players[index_path.row][:first]} #{@players[index_path.row][:last]}"

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

    self.parentViewController.pushViewController(self.edit_player_controller, animated: true)
  end

  def edit_player_controller
    @edit_player_controller ||= EditPlayerController.new
  end

  def playersChanged
    puts "playersChanged"
    @table_view.reloadData
  end

  def addPlayer
    puts "addPlayer"
    edit_player_controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical
    edit_player_controller.delegate = self
    self.presentViewController(edit_player_controller, animated:true, completion:nil)
  end

  def tableView(tableView, commitEditingStyle:editing_style, forRowAtIndexPath:index_path)
    if editing_style == UITableViewCellEditingStyleDelete
      editing_style = "UITableViewCellEditingStyleDelete"
      @players.delete_at(index_path.row)
      @table_view.deleteRowsAtIndexPaths([index_path], withRowAnimation:UITableViewRowAnimationAutomatic)
    end
    puts "tableView(#{tableView}, commitEditingStyle:#{editing_style}, forRowAtIndexPath:#{index_path})"
  end

  def tableView(tableView, moveRowAtIndexPath:from_index_path, toIndexPath:to_index_path)
    puts "tableView(#{tableView}, moveRowAtIndexPath:#{from_index_path}, toIndexPath:#{to_index_path})"
    move = @players.delete_at(from_index_path.row)
    if move
      @players.insert(to_index_path.row, move)
    end
  end

  def setEditing(is_editing, animated:is_animated)
    puts "setEditing(#{is_editing}, animated:#{is_animated})"
    @table_view.setEditing(is_editing, animated:is_animated)
    super
  end

end