import React from "react";
import { BrowserRouter, Route } from "react-router-dom";
import NavUp from "./Component/NavUp";
import NavRight from "./Component/NavRight";

function App() {
  return (
    <div className="App">
      <NavUp />
      <NavRight />
    </div>
  );
}

export default App;
