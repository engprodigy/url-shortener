import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { List } from 'immutable';



import UrlForm from '../../components/url-form';
import UrlList from '../../components/url-list';



export class TasksPage extends Component {
  static propTypes = {
    urls: PropTypes.instanceOf(List)
    
  };

  
  render() {
    return (
      <div className="g-row">
        <div className="g-col">
          <UrlForm  />
        </div>

        <div className="g-col">
        <UrlList
            
            urls={this.props.urls}
            
          />
          
        </div>

        
      </div>
    );
  }
}



export default (TasksPage);
