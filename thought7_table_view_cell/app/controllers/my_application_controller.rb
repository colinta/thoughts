ICON_TAG = 1
TITLE_TAG = 2
DESCRIPTION_TAG = 3
LOGO1_TAG = 4
LOGO2_TAG = 5

class MyApplicationController < UIViewController

  stylesheet  :cell_sheet

  def layoutDidLoad
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
      { icon: 'woahsupercool',
        project: 'WoahSuperCool',
        description: 'No beer and no TV make Colin something something. No beer and no TV make Colin something something. No beer and no TV make Colin something something.',
        logos: ['twitter', 'github']
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

  def description_frame
    [[50, 20], [245, 30]]
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)

    if not cell
      cell = UITableViewCell.alloc.initWithStyle( UITableViewCellStyleDefault,
                          reuseIdentifier: cell_identifier)

      layout(cell.contentView, :cell) do
        icon_image_view = subview(UIImageView, :icon, tag: ICON_TAG)
        title_view = subview(UILabel, :title, tag: TITLE_TAG, font: UIFont.systemFontOfSize(17))
        description_view = subview(UILabel, :description, tag: DESCRIPTION_TAG, font: UIFont.systemFontOfSize(12))
        logo1_view = subview(UIImageView, :logo1, tag: LOGO1_TAG)
        logo2_view = subview(UIImageView, :logo2, tag: LOGO2_TAG)
      end
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
    # if the height is too large, it will exceed the height I want it to be, so
    # I will manually just cut it off.  comment these out to SEE WHAT HAPPENS :-|
    frame = description_view.frame
    frame.size.height = description_frame[1][1]
    description_view.frame = frame
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
