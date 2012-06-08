class MyApplicationController < UIViewController

  def viewDidLoad
    @data = [
      {first: 'firsty', last: 'McLasty'},
      {first: 'humphrey', last: 'bogart'},
    ]
    @table = UITableView.alloc.initWithFrame view.all, style: UITableViewStylePlain
    @table.dataSource = self
    view.addSubview(@table)
  end

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
