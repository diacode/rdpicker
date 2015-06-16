Portal = require './portal.cjsx'
Calendar = require './calendar.cjsx'

module.exports = React.createClass
  displayName: 'DateInput'

  getInitialState: ->
    calendarVisible: false
    formatedDates: ''
    selectedDates: []

  getDefaultProps: ->
    shortDateFormat: 'D/M'
    initDates: null 

  hideCalendar: ->
    @setState
      calendarVisible: false

  showCalendar: ->
    @setState
      calendarVisible: true

  reset: ->
    @replaceState @getInitialState()

  componentWillMount: ->
    if @props.initDates
      dates = @props.initDates.split(',')
      @setState
        selectedDates: dates.map (date) -> moment(date.trim(), 'L')

  componentDidUpdate: (prevProps, prevState) ->
    if prevState.selectedDates != @state.selectedDates
      if @props.multiple
        @props.onChange(@state.selectedDates)
      else
        @props.onChange(@state.selectedDates[0])

  componentWillReceiveProps: (nextProps) ->
    return unless @state.selectedDates.length > 0

    if moment.isMoment(nextProps.minDate)
      # Remove dates that are past to minDate
      filteredDates = @state.selectedDates.filter (d) -> 
        not d.isBefore(nextProps.minDate, 'day')

      if filteredDates.length != @state.selectedDates.length
        @setState
          selectedDates: filteredDates
  
  getValue: ->
    @refs.input.getDOMNode().value

  _onClick: ->
    @setState
      calendarVisible: true

  _onAddDate: (date) ->
    if @props.multiple
      @_updateDates @state.selectedDates.concat([date])
    else
      @_updateDates [date]
      @hideCalendar()


  _onRemoveDate: (date) ->
    if @props.multiple
      newDates = @state.selectedDates.filter (d) -> 
        d.isSame(date, 'day') is false
    else
      newDates = []

    @_updateDates(newDates)

  _onClearDates: ->
    @_updateDates([])
    @hideCalendar()
    
  _updateDates: (newDates) ->
    # Before changing the state let's sort the dates 
    newDates.sort(@_compareMomentDates)

    @setState
      selectedDates: newDates


  _formatedDates: ->
    formatedDates = @state.selectedDates.map (date) -> date.format('L')

    if @props.multiple
      formatedDates.join(',')
    else
      formatedDates[0]

  _formatedShortDates: ->
    formatedDates = @state.selectedDates.map (date) => date.format(@props.shortDateFormat)

    if @props.multiple
      formatedDates.join(', ')
    else
      formatedDates[0]

  # Compare two moment.js objects (dates)
  _compareMomentDates: (a, b) ->
    if a.valueOf() < b.valueOf()
      -1
    else if a.valueOf() > b.valueOf()
      1
    else
      0

  # Multiple inputs use a hidden input with a different date format
  _renderInput: ->
    if @props.multiple
      <div>
        <input ref='input' type='hidden' value={@_formatedDates()} name={@props.inputOptions.name} id={@props.inputOptions.id} />
        <input type='text' onClick={@_onClick} value={@_formatedShortDates()} placeholder={@props.inputOptions.placeholder} readOnly/>
      </div>
    else
      <input ref='input' type='text' onClick={@_onClick} value={@_formatedDates()} name={@props.inputOptions.name} id={@props.inputOptions.id} placeholder={@props.inputOptions.placeholder} readOnly/>


  _renderCalendar: ->
    calendarProps = 
      selectedDates: @state.selectedDates
      hideCalendar: @hideCalendar
      onAddDate: @_onAddDate
      onRemoveDate: @_onRemoveDate
      onClearDates: @_onClearDates

    <Calendar {...calendarProps} {...@props} />

  _renderCalendarWrapper: ->
    return unless @state.calendarVisible
    if window.innerWidth < @props.minWidthForDialogMode
      # On mobile devices we use a Portal to create a modal dialog
      <Portal className='calendarWrapper' isOpened={true} closeOnEsc={true} closeOnOutsideClick={false}>
        {@_renderCalendar()}
      </Portal>
    else
      @_renderCalendar()

  render: () ->
    <div>
      {@_renderInput()}
      {@_renderCalendarWrapper()}
    </div>