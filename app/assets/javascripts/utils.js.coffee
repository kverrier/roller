Window.formatTime = (secs) -> ('0' + Math.floor(secs / 60)).slice(-2) + ":" + ('0' + Math.floor(secs % 60)).slice(-2)
