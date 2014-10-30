$(document).ready ->
  
  DRAW_OPTS.canvas = oCanvas.create
    canvas: "#main"
    background: "#000"
  
  #$("#container").css "height", $(window).height()
  #$("#container").css "width", $(window).width()
  $("#container").css "height", ~~($(window).height() / DRAW_OPTS.tiles.x9) * DRAW_OPTS.tiles.x9
  $("#container").css "width", ~~($(window).width() / DRAW_OPTS.tiles.x9) * DRAW_OPTS.tiles.x9
  DRAW_OPTS.canvas.height = $("#container").height()
  DRAW_OPTS.canvas.width = $("#container").width()
  
  window.regenerate = ->
    xLeft = $("#container").width()
    yLeft = $("#container").height()
    currentX = 0
    currentY = 0
    DRAW_OPTS.tiles_drawn = []
    while yLeft >= DRAW_OPTS.tiles.x9
      while xLeft >= DRAW_OPTS.tiles.x9
        DRAW_OPTS.tiles_drawn += DRAW_OPTS.generateTile currentX, currentY
        xLeft -= DRAW_OPTS.tiles.x9
        currentX += DRAW_OPTS.tiles.x9
      xLeft = $("#container").width()
      currentX = 0
      yLeft -= DRAW_OPTS.tiles.x9
      currentY += DRAW_OPTS.tiles.x9
    DRAW_OPTS.canvas.redraw()
  regenerate()
  DRAW_OPTS.canvas.setLoop( ->
    if DRAW_OPTS.animation
      regenerate()
  ).start()