import React  from 'react';
import { List } from 'immutable';
import PropTypes from 'prop-types';
import UrlItem from '../url-item/url-item';


function UrlList({urls}) {
  let urlItems;
  if (urls){
  urlItems = urls.map((url, index) => {
    return (
      <UrlItem
        
        url={url}
        
      />
    );
  });
}
  return (
    <div className="task-list">
      {urlItems}
    </div>
  );
}

UrlList.propTypes = {
  
  urls: PropTypes.instanceOf(List),
  
};

export default UrlList;
