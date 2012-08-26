AwesomeLabels = [
                  "Really awesome",
                  "Awesome",  # default
                  "Pretty darn awesome",
                  "I would still call this awesome",
                  "Not awesome, really, but maybe a little",
                  "Okay, yeah, it's awesome",
                ]

class MyApplicationController < UIViewController
  def init
    super && self.tap {
      @awesomeness = 1
    }
  end

  def viewDidLoad
    @table_view = UITableView.grouped
    @table_view.dataSource = self
    @table_view.delegate = self

    self.view << @table_view

    @modal_view = UIControl.alloc.initWithFrame(self.view.bounds)
    @modal_view.backgroundColor = :black.uicolor(0.5)
    @modal_view.alpha = 0.0

    @modal_view.on :touch do
      cancel
    end

    self.view << @modal_view

    @keyboard_view = UIView.alloc.initWithFrame([[0, 460], [320, 260]])
    self.view << @keyboard_view

    nav_bar = UINavigationBar.alloc.initWithFrame([[0, 0], [320, 44]])

    item = UINavigationItem.new
    item.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
        UIBarButtonSystemItemCancel,
        target: self,
        action: :cancel)

    item.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(
        UIBarButtonSystemItemDone,
        target: self,
        action: :done)

    nav_bar.items = [item]
    @keyboard_view << nav_bar

    @picker_delegate = AwesomePickerDelegate.new
    @picker_view = UIPickerView.alloc.initWithFrame([[0, 44], [320, 216]])
    @picker_view.showsSelectionIndicator = true
    @picker_view.delegate = @picker_view.dataSource = @picker_delegate
    @picker_view.selectRow(@awesomeness, inComponent:0, animated:false)
    @keyboard_view << @picker_view
  end

  def tableView(table_view, cellForRowAtIndexPath:index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('Cell')

    unless cell
      cell = UITableViewCell.alloc.initWithStyle(:value1.uitablecellstyle,   # !?
                                 reuseIdentifier:'Cell')
      cell.textLabel.text = "Awesomeness"
    end

    cell.detailTextLabel.text = AwesomeLabels[@awesomeness]
    return cell
  end

  def tableView(table_view, titleForHeaderInSection:section)
    "Settings"
  end

  def tableView(table_view, numberOfRowsInSection:section)
    1
  end

  def tableView(table_view, didSelectRowAtIndexPath:index_path)
    table_view.deselectRowAtIndexPath(index_path, animated:true)

    # @picker_view.selectRow(@awesomeness, inComponent:0, animated:false)
    @modal_view.fade_in
    @keyboard_view.slide :up
  end

  def done
    @awesomeness = @picker_view.selectedRowInComponent(0)
    @table_view.reloadData
    cancel
  end

  def cancel
    @modal_view.fade_out
    @keyboard_view.slide :down
  end

end


class AwesomePickerDelegate

  def numberOfComponentsInPickerView(picker_view)
    1
  end

  def pickerView(picker_view, numberOfRowsInComponent:section)
    AwesomeLabels.length
  end

  def pickerView(picker_view, titleForRow:row, forComponent:section)
    AwesomeLabels[row].to_s
  end

end
