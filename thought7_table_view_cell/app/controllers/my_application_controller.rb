ICON_TAG = 1
TITLE_TAG = 2
DESCRIPTION_TAG = 3
LOGO1_TAG = 4
LOGO2_TAG = 5

class MyApplicationController < UIViewController

  def viewDidLoad
    @data = [
      { icon: 'niftywow',
        project: 'NiftyWow',
        description: "Oh you just can't imagine.",
        logos: ['apple', 'github']
        },
      { icon: 'amazingwhizbang',
        project: 'AmazingWhizBang',
        description: 'Much cooler than lame stuff.',
        logos: ['apple', 'twitter']
        },
    ]
    @table = UITableView.alloc.initWithFrame [[0, 0], [320, 480]], style: UITableViewStylePlain
    @table.dataSource = self
    @table.delegate = self
    view.addSubview(@table)
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    50
  end

  def icon_frame
    [[5, 5], [40, 40]]
  end

  def title_frame
    [[50, 0], [245, 20]]
  end

  def description_frame
    [[50, 20], [245, 30]]
  end

  def logo1_frame
    [[295,  5], [20, 20]]
  end

  def logo2_frame
    [[295, 25], [20, 20]]
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)

    if not cell
      cell = UITableViewCell.alloc.initWithStyle( UITableViewCellStyleDefault,
                          reuseIdentifier: cell_identifier)

      icon_image_view = UIImageView.new
      icon_image_view.frame = icon_frame
      icon_image_view.tag = ICON_TAG
      cell.contentView.addSubview(icon_image_view)

      title_view = UILabel.alloc.initWithFrame(title_frame)
      title_view.font = UIFont.systemFontOfSize(17)
      title_view.tag = TITLE_TAG
      cell.contentView.addSubview(title_view)

      description_view = UILabel.alloc.initWithFrame(description_frame)
      description_view.font = UIFont.systemFontOfSize(12)
      description_view.textColor = UIColor.grayColor
      description_view.lineBreakMode = UILineBreakModeWordWrap
      description_view.numberOfLines = 0
      description_view.tag = DESCRIPTION_TAG
      cell.contentView.addSubview(description_view)

      logo1_view = UIImageView.alloc.initWithFrame(logo1_frame)
      logo1_view.tag = LOGO1_TAG
      cell.contentView.addSubview(logo1_view)

      logo2_view = UIImageView.alloc.initWithFrame(logo2_frame)
      logo2_view.tag = LOGO2_TAG
      cell.contentView.addSubview(logo2_view)
    else  # the cell *did* exist
      icon_image_view = cell.viewWithTag(ICON_TAG)
      title_view = cell.viewWithTag(TITLE_TAG)
      description_view = cell.viewWithTag(DESCRIPTION_TAG)
      logo1_view = cell.viewWithTag(LOGO1_TAG)
      logo2_view = cell.viewWithTag(LOGO2_TAG)
    end

    project = @data[indexPath.row]

    icon_image_view.image = UIImage.imageNamed(project[:icon])
    title_view.text = project[:project]
    description_view.text = project[:description]
    description_view.frame = description_frame
    description_view.sizeToFit
    logo1_view.image = UIImage.imageNamed(project[:logos][0])
    logo2_view.image = UIImage.imageNamed(project[:logos][1])

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

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  end

end
