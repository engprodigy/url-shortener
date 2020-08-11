export const API_KEY = 'e36c39cf3e4433cbbdb75bad088f440d';
//export const PATH_BASE = 'https://api.themoviedb.org/3';
export const PATH_BASE = process.env.REACT_APP_API_URL;   //http://urls.com/yourls-api.php?

export const KEYWORD = '&keyword';
export const URL = '&url';
export const FORMAT = '&format=json';

//export const USERNAME = '&username=' + process.env.REACT_APP_API_USERNAME;
export const USERNAME = process.env.REACT_APP_API_USERNAME;
//export const PASSWORD = '&password=' + process.env.REACT_APP_API_PASSWORD;
export const PASSWORD = process.env.REACT_APP_API_PASSWORD;
export const ACTION = '&action=shorturl';

