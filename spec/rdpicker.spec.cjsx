Rdpicker = require '../lib/rdpicker.cjsx'


describe 'Rdpicker', ->
  component = null
  beforeEach ->
    component = React.addons.TestUtils.renderIntoDocument(
      <Rdpicker/>
    )

  it 'should render', ->
    expect(component.className).toEqual('rdpicker')
