require './rdpicker.scss'

DateInput = require './date_input.cjsx'

module.exports = React.createClass
  displayName: 'Rdpicker'

  propTypes:
    selectionType: React.PropTypes.oneOf(['single', 'multiple'])

  getDefaultProps: ->
    selectionType: 'single'
    minDate: moment()
    locale: 'en'
    minWidthForDialogMode: 900
    initDates:  null
    inputOptions: 
      name: 'date'
      id: 'rdpicker_date'
    onChange: (dates) -> {}

  # Returns the value for the text input 
  # or the hidden input (if selectionType is multiple)
  getInputValue: ->
    @refs.dateInput.getValue()

  showCalendar: ->
    @refs.dateInput.showCalendar()

  _renderSingle: ->
    <div className="rdpicker">
      <DateInput ref='dateInput' {...@props} multiple={false} />
    </div>

  _renderMultiple: ->
    <div className="rdpicker">
      <DateInput ref='dateInput' {...@props} multiple={true} />
    </div>

  render: () ->
    switch @props.selectionType
      when 'single'
        @_renderSingle()
      when 'multiple'
        @_renderMultiple()
