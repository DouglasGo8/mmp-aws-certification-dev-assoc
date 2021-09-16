import React, {useState} from "react";

import "./App.css";

/**
 *
 * @returns {JSX.Element}
 * @constructor
 */
const App = () => {
  const [hostName] = useState(window.location.hostname)

  return (
    <div className="main">
      <h1> Hello from ReactJS app on <span className="host">{hostName}</span></h1>
      <hr/>
    </div>
  );
};

export default App;
