/**
 * Configuration for the Phoenix OSX window manager
 *
 * https://github.com/kasper/phoenix
 *
 */
var mash = ['cmd', 'ctrl'];

var fullscreen = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x,
      y: screen.y
    });
    window.setSize({
      width: screen.width,
      height: screen.height
    });
  }
}

var center = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x + screen.width * 0.125,
      y: screen.y + screen.height * 0.125
    });
    window.setSize({
      width: screen.width * 0.75,
      height: screen.height * 0.75
    });
  }
}

var lefthalf = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x,
      y: screen.y
    });
    window.setSize({
      width: screen.width * 0.5,
      height: screen.height
    });
  }
}

var righthalf = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x + screen.width * 0.5,
      y: screen.y
    });
    window.setSize({
      width: screen.width * 0.5,
      height: screen.height
    });
  }
}

Key.on('c', mash, center);
Key.on('l', mash, lefthalf);
Key.on('r', mash, righthalf);
Key.on('f', mash, fullscreen);
