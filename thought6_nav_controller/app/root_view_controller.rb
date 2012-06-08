
# this will be a table view, with which we can select our next view
class RootViewController < UIViewController
  attr_reader :table

  def viewDidLoad
    self.title = "The playas"
    # self.parentViewController.delegate = self

    @data = [
      {first: 'firsty', last: 'McLasty'},
      {first: 'humphrey', last: 'bogart'},
    ]

    @table = UITableView.alloc.initWithFrame([[0, 0], [self.view.frame.size.width, self.view.frame.size.height]],
                                       style: UITableViewStylePlain)
    @table.dataSource = self
    @table.delegate = self
    view.addSubview(@table)
  end

  # new code!
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    view_controller = DetailViewController.alloc.initWithCharacter(@data[indexPath.row])
    view_controller.playas_controller = self

    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    self.parentViewController.pushViewController(view_controller, animated: true)
  end

  def navigationController(navigationController, willShowViewController:viewController, animated:animated)
    if viewController == self
      @table.reloadData
    end
  end

  ############################# TABLE DATA SOURCE ##############################
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier) ||
          UITableViewCell.alloc.initWithStyle( UITableViewCellStyleDefault,
                              reuseIdentifier: cell_identifier)
    cell.textLabel.text = "#{@data[indexPath.row][:first]} #{@data[indexPath.row][:last]}"

    return cell
  end

  def cell_identifier
    @@cell_identifier ||= 'Cell'
  end

  def tableView(tableView, numberOfRowsInSection: section)
    case section
    when 0
      @data.length
    else
      0
    end
  end

end
