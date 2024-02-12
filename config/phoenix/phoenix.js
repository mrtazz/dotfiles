/**
 * Configuration for the Phoenix OSX window manager
 *
 * https://github.com/kasper/phoenix
 *
 */
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
      y: screen.y
    });
    window.setSize({
      width: screen.width * 0.75,
      height: screen.height
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

var right_two_thirds = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x + screen.width * 0.33,
      y: screen.y
    });
    window.setSize({
      width: screen.width * 0.667,
      height: screen.height
    });
  }
}

var left_two_thirds = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x,
      y: screen.y
    });
    window.setSize({
      width: screen.width * 0.667,
      height: screen.height
    });
  }
}

var tophalf = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x,
      y: screen.y
    });
    window.setSize({
      width: screen.width,
      height: screen.height * 0.5
    });
  }
}

var bottomhalf = function () {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    window.setTopLeft({
      x: screen.x,
      y: screen.y + screen.height * 0.5
    });
    window.setSize({
      width: screen.width,
      height: screen.height * 0.5
    });
  }
}

var quarterScreen = function (position) {

  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  var newWindow = {
    position: {
      x: screen.x,
      y: screen.y
    },
    size: {
      width: screen.width * 0.5,
      height: screen.height * 0.5
    }
  }

  switch(position) {
    case 'lefttop':
      newWindow['position'] = { x: screen.x, y: screen.y };
      newWindow['size'] = { width: screen.width * 0.5, height: screen.height * 0.5 };
      break;
    case 'leftbottom':
      newWindow['position'] = { x: screen.x, y: screen.y + screen.height * 0.5 };
      newWindow['size'] = { width: screen.width * 0.5, height: screen.height * 0.5 };
      break;
    case 'righttop':
      newWindow['position'] = { x: screen.x + screen.width * 0.5, y: screen.y };
      newWindow['size'] = { width: screen.width * 0.5, height: screen.height * 0.5 };
      break;
    case 'rightbottom':
      newWindow['position'] = { x: screen.x + screen.width * 0.5, y: screen.y + screen.height * 0.5 };
      newWindow['size'] = { width: screen.width * 0.5, height: screen.height * 0.5 };
      break;
  }

  if (window) {
    window.setTopLeft(newWindow['position']);
    window.setSize(newWindow['size']);
  }
}

var mash = ['cmd', 'ctrl'];

// window positioning shortcuts
Key.on('c', mash, center);
Key.on('l', mash, lefthalf);
Key.on('r', mash, righthalf);
Key.on('f', mash, fullscreen);
Key.on('q', mash, function() { quarterScreen('lefttop'); });
Key.on('w', mash, function() { quarterScreen('righttop'); });
Key.on('a', mash, function() { quarterScreen('leftbottom'); });
Key.on('s', mash, function() { quarterScreen('rightbottom'); });
Key.on('e', mash, tophalf);
Key.on('d', mash, bottomhalf);

// app launching
var app_mash = ['cmd', 'ctrl', 'shift', 'option'];
Key.on('t', app_mash, function() { App.launch('Alacritty', { focus: true }); });
Key.on('b', app_mash, function() { App.launch('Firefox', { focus: true }); });
Key.on('s', app_mash, function() { App.launch('Slack', { focus: true }); });
