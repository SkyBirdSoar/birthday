create_x1_Tile = (x, y) ->
  DRAW_OPTS.canvas.display.rectangle
    x: x
    y: y
    origin:
      x: "left"
      y: "top"
    height: DRAW_OPTS.tiles.x1
    width: DRAW_OPTS.tiles.x1
    fill: DRAW_OPTS.randomFill()

create_x4_Tile = (x, y) ->
  DRAW_OPTS.canvas.display.rectangle
    x: x
    y: y
    origin:
      x: "left"
      y: "top"
    height: DRAW_OPTS.tiles.x4
    width: DRAW_OPTS.tiles.x4
    fill: DRAW_OPTS.randomFill()

create_x9_Tile = (x, y) ->
  DRAW_OPTS.canvas.display.rectangle
    x: x
    y: y
    origin:
      x: "left"
      y: "top"
    height: DRAW_OPTS.tiles.x9
    width: DRAW_OPTS.tiles.x9
    fill: DRAW_OPTS.randomFill()
    
# - - - - - - - - - - - - - - - - - - - - - - - - #
generate4 = -> Math.floor Math.random() * 4
randomLetter = -> DRAW_OPTS.letters[Math.floor(Math.random() * DRAW_OPTS.letters.length)]
randomOrientation = ->
  switch generate4()
    when 0 then 0
    when 1 then 90
    when 2 then 180
    when 3 then 270

createLetter = (len, letter, size) ->
  DRAW_OPTS.canvas.display.text
    x: len / 2
    y: len / 2
    origin:
      x: "center"
      y: "center"
    text: letter
    size: size
    fill: "#000"
    font: "bold " + size + "px " + DRAW_OPTS.font

setUpTile = (size, x, y, base) ->
  switch size
    when 1
      tile = create_x1_Tile x, y
      if Math.random() < DRAW_OPTS.chance.letter
        letter = createLetter DRAW_OPTS.tiles.x1, randomLetter(), DRAW_OPTS.fontSize.x1 
        tile.addChild letter
    when 4
      tile = create_x4_Tile x, y
      if Math.random() < DRAW_OPTS.chance.letter
        letter = createLetter DRAW_OPTS.tiles.x4, randomLetter(), DRAW_OPTS.fontSize.x4
        tile.addChild letter
    when 9
      tile = create_x9_Tile x, y
      if Math.random() < DRAW_OPTS.chance.letter
        letter = createLetter DRAW_OPTS.tiles.x9, randomLetter(), DRAW_OPTS.fontSize.x9
        tile.addChild letter
  # tile.rotate randomOrientation()
  base.addChild tile
  [tile, letter]

DRAW_OPTS.generateTile = (x, y) ->
  base = setUpTile 9, x, y, DRAW_OPTS.canvas
  letter = base[1]
  base = base[0]
  if Math.random() > DRAW_OPTS.chance.x9
    # Make smaller tiles
    base.removeChild letter
    if Math.random() > DRAW_OPTS.chance.x4
      # No 4x4 tile; 9 1x1 tiles
      i = 0
      while i < 3
        y = i * DRAW_OPTS.tiles.x1
        j = 0
        while j < 3
          x = j * DRAW_OPTS.tiles.x1
          setUpTile 1, x, y, base
          j++
        i++
    else
      # 4x4 tile + 5 1x1 tiles
      switch generate4()
        when 0
          # 4x4 tile on top left
          setUpTile 4, 0, 0, base
          
          x = DRAW_OPTS.tiles.x4
          i = 0
          while i < 3
            y = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
          
          y = DRAW_OPTS.tiles.x4
          i = 0
          while i < 2
            x = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
        when 1
          # 4x4 tile on top right
          setUpTile 4, DRAW_OPTS.tiles.x1, 0, base
          
          x = 0
          i = 0
          while i < 3
            y = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
          
          y = DRAW_OPTS.tiles.x4
          i = 1
          while i < 2
            x = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
        when 2
          # 4x4 tile on bottom left
          setUpTile 4, 0, DRAW_OPTS.tiles.x1, base
          
          y = 0
          i = 0
          while i < 3
            x = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
          
          x = DRAW_OPTS.tiles.x4
          i = 1
          while i < 2
            y = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
        when 3
          # 4x4 tile on bottom right
          setUpTile 4, DRAW_OPTS.tiles.x1, DRAW_OPTS.tiles.x1, base
          
          y = 0
          i = 0
          while i < 3
            x = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
          
          x = 0
          i = 1
          while i < 2
            y = i * DRAW_OPTS.tiles.x1
            setUpTile 1, x, y, base
            i++
  base