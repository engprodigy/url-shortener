import React, { Component } from 'react';
import classNames from 'classnames';
import PropTypes from 'prop-types';
import Button from '../button';
import Icon from '../icon';

import './task-item.css';


export class UrlItem extends Component {
  constructor() {
    super(...arguments);

   
  }

 
 
 

  render() {
    
    const { url } = this.props;

    // let containerClasses = classNames('task-item', {
    //   'task-item--completed': task.completed,
    //   'task-item--editing': editing
    // });

    return (
      <div className="task-item" tabIndex="0">
        

        <div className="cell">
          <div className="task-item__title" tabIndex="0">

               {url}
                      
            </div>
        </div>

       
      </div>
    );
  }
}

UrlItem.propTypes = {
  
  url: PropTypes.object.isRequired,
  
};


export default UrlItem;
