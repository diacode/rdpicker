DayNames = require './day_names.cjsx'
Day = require './day.cjsx'
onClickOutside = require 'react-onclickoutside'

module.exports = onClickOutside(React.createClass
  displayName: 'Calendar'

  handleClickOutside: ->
    @props.hideCalendar()

  getInitialState: ->
    month: if @props.minDate then @props.minDate.clone().startOf("month").locale(moment.locale()) else moment().startOf("month")

  getDefaultProps: ->
    minDate: moment()
    i18n:
      clearDates: 'Clear dates'

  componentWillReceiveProps: (nextProps) ->
    if moment.isMoment(nextProps.minDate) && (nextProps.selectedDates.length == 0) && !nextProps.minDate.isSame(@props.minDate)
      @setState
        month: nextProps.minDate.clone().startOf("month").locale(moment.locale())

  _handlePreviousMonthClick: () ->
    month = @state.month.add(-1,'M')
    @setState
      month: month

  _handleNextMonthClick: () ->
    month = @state.month.add(1,'M')
    @setState
      month: month

  _handleCloseCalendarClick: (event) ->
    event.preventDefault()
    @props.onClearDates()

  _onAddDate: (date) ->
    @props.onAddDate(date)

  _onRemoveDate: (date) ->
    @props.onRemoveDate(date)

  _belongsToSelectedDates: (date) ->
    for d in @props.selectedDates
      return true if d.isSame(date, 'day')

  _renderWeek: (date, month, today) ->
    days = []

    for i in [0...7] by 1
      isCurrentMonth = date.month() is month.month()
      isSelectable = !@props.minDate || (isCurrentMonth && (date.isSame(@props.minDate, 'day') || date.isAfter(@props.minDate, 'day')))
      dayProps =
        key: i
        date: date
        isToday: date.isSame(today, "day")
        isCurrentMonth: isCurrentMonth
        isSelectable: isSelectable
        selected:  @_belongsToSelectedDates(date)
        onAddDate: @_onAddDate
        onRemoveDate: @_onRemoveDate

      days.push <Day {...dayProps}/>
      date = date.clone()
      date.add(1, "d")

    <div className="week" key={date.format('L')}>
      {days}
    </div>


  _renderWeeks: () ->
    weeks = []
    done = false
    date = @state.month.clone().startOf("month").startOf("week")
    monthIndex = date.month()
    count = 0

    while not done
      weeks.push @_renderWeek(date.clone(), @state.month, moment())

      date.add(1, "w")
      done = count++ > 2 && monthIndex != date.month()
      monthIndex = date.month()

    weeks

  _renderMonthLabel: () ->
    <span>{@state.month.format("MMMM YYYY")}</span>

  _renderFooter: ->
    return unless @props.onClearDates
    <footer className="footer">
      <button className="close-calendar" onClick={@_handleCloseCalendarClick}>{@props.i18n.clearDates}</button>
    </footer>

  render: () ->
    <div className="calendar">
      <header className="header">
        <i className="prev" onClick={@_handlePreviousMonthClick}> < </i>
        {@_renderMonthLabel()}
        <i className="next" onClick={@_handleNextMonthClick}> > </i>
      </header>
      <div className="body">
        <DayNames />
        {@_renderWeeks()}
      </div>
      
      {@_renderFooter()}
    </div>
)