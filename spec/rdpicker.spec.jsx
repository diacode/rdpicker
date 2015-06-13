import React from 'react/addons';
import Rdpicker from '../lib/rdpicker.jsx';

describe('Rdpicker', function() {
  var component;

  beforeEach(function() {
    component = React.addons.TestUtils.renderIntoDocument(
      <Rdpicker/>
    );
  });

  it('should render', function() {
    expect(component.getDOMNode().className).toEqual('rdpicker');
  });
});
