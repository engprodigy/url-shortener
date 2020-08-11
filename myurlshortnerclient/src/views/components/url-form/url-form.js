import React, { Component } from 'react';
import PropTypes from 'prop-types';

import './task-form.css';
import { URL, PATH_BASE, KEYWORD, FORMAT, USERNAME, PASSWORD, ACTION } from '../../../api';


export class UrlForm extends Component {
  // static propTypes = {
  //   handleSubmit: PropTypes.func.isRequired
  // };

  constructor() {
    super(...arguments);

    this.state = {title: '', shrturl: ''};
    
    this.handleChange = this.handleChange.bind(this);
    this.handleKeyUp = this.handleKeyUp.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }
 
  clearInput() {
    this.setState({title: ''});
  }

  handleChange(event) {
    this.setState({title: event.target.value, shrturl: ''});
  }

  handleKeyUp(event) {
    if (event.keyCode === 27) this.clearInput();
  }

  handleSubmit(event) {
    event.preventDefault();
    const title = this.state.title.trim();
    const keyword = Math.random().toString(36).substr(2, 5);
   
    if (title.length) //this.props.handleSubmit(title);
    fetch(`${PATH_BASE}${URL}=${title}${KEYWORD}=${keyword}${FORMAT}&username=${USERNAME}&password=${PASSWORD}${ACTION}`,
    {
      
      method: 'POST',
    })
   
   //fetch(`${PATH_BASE}${PATH_SEARCH}${PATH_SHOW}?q=girls`)
    .then(response => response.json())
    .then((result) => this.setState({ shrturl: result.shorturl }
      
        
         ))
         .catch((error) => {
          console.error('Error:', error);
        });
    
    
   
    this.clearInput();
   
  }

  render() {
    return (
      <div>
      <form className="task-form" onSubmit={this.handleSubmit} noValidate>
        <input
          autoComplete="off"
          autoFocus
          className="task-form__input"
          maxLength="64"
          onChange={this.handleChange}
          onKeyUp={this.handleKeyUp}
          placeholder="Enter URL to shorten then press Enter"
          ref={e => this.titleInput = e}
          type="text"
          value={this.state.title}
        />
      </form>
      <div className="task-list">
           <div className="task-item" tabIndex="0">
        

                  <div className="cell">
                      <div className="task-item__title" tabIndex="0">

                      {this.state.shrturl}
                    
                             </div>
                   </div>

     
            </div>
      </div>
    </div>
    );
  }
}


export default UrlForm;
