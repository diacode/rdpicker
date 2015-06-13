CSSPropertyOperations = require 'react/lib/CSSPropertyOperations'
shallowEqual = require 'react/lib/shallowEqual'

# React portal inspired by
# https://gist.github.com/ryanflorence/ac5174cf97dd596e949c
# https://github.com/tajo/react-portal/blob/master/lib/portal.js

module.exports = React.createClass
  displayName: 'Portal'

  componentDidMount: ->
    if @props.closeOnEsc
      document.addEventListener('keydown', @handleKeydown)

  componentWillMount: ->
    if @props.isOpened
      @openPortal()

  componentWillReceiveProps: (newProps) ->
    if newProps.isOpened && @newProps != @props
      if newProps.isOpened
        @renderPortal(newProps)
      if !newProps.isOpened && @state.active
        @closePortal()

  componentWillUnmount: ->
    if @props.closeOnEsc
      document.removeEventListener('keydown', @handleKeydown)

    @closePortal()

  shouldComponentUpdate: (nextProps, nextState) ->
    return !shallowEqual(@props, nextProps) ||
           !shallowEqual(@state, nextState)

  renderPortal: (props) ->
    if !@node
      @node = document.createElement('div')
      if @props.className
        @node.className = @props.className
      if @props.style
        CSSPropertyOperations.setValueForStyles(@node, @props.style)
      document.body.appendChild(@node)
    @portal = React.render(React.cloneElement(props.children, {closePortal: @closePortal}), @node)
  

  render: ->
    if @props.openByClickOn
      <div className="openByClickOn" onClick={@openPortal}>{@props.openByClickOn}</div>
    else
      null

  openPortal: (e) ->
    if e
      e.preventDefault()
      e.stopPropagation()
    @setState({active: true})
    @renderPortal(@props)

  closePortal: ->
    if @node
      React.unmountComponentAtNode(@node)
      document.body.removeChild(@node)
    @portal = null
    @node = null
    @setState({active: false})

    if @props.onClose
      @props.onClose()

  handleKeydown: (e) ->
    # ESC
    if e.keyCode == 27
      @closePortal()

