module.exports = React.createClass
  displayName: 'DayNames'

  # mixins: [
  #   React.addons.PureRenderMixin
  # ]

  _renderNames: ->
    firstDayOfWeek = moment.localeData().firstDayOfWeek()
    lastDayOfWeek = firstDayOfWeek + 6
    
    [firstDayOfWeek..lastDayOfWeek].map (i) ->
      day = moment.weekdaysMin(i)
      <div key={day} className="day"><span>{day}</span></div>

  render: () ->
    <div className="week-day-names">
      {@_renderNames()}
    </div>
