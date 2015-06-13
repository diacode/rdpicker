classnames = require 'classnames'

module.exports = React.createClass
  displayName: 'Day'

  getDefaultProps: ->
    selected: false

  _onClick: (e)->
    e.preventDefault()
    return unless @props.isSelectable

    if @props.selected
      @props.onRemoveDate(@props.date)
    else
      @props.onAddDate(@props.date)

  render: ->
    day = @props.date.format("YYYY-MM-DD")

    dayClasses = classnames
      day: true
      today: @props.isToday
      'different-month': not @props.isCurrentMonth
      unselectable: !@props.isSelectable
      selected: @props.selected

    <div id={"rdpicker_day_" + day} key={day} className={dayClasses} onClick={@_onClick}>
      <span className="day-number">{@props.date.date()}</span>
    </div>
