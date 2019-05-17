/* Set the width of the sidebar to 250px (show it) */
function openNav() {
    document.getElementById("left-sidebar").style.width = "300px";
    document.getElementById("orders-container").style.marginLeft = "350px";
  }
  
  /* Set the width of the sidebar to 0 (hide it) */
  function closeNav() {
    document.getElementById("left-sidebar").style.width = "0";
    document.getElementById("orders-container").style.marginLeft = "35px";
  }