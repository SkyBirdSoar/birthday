window.DRAW_OPTS =
  tiles:
    x1: 65
    x4: 130
    x9: 195
  fontSize:
    x1: 55
    x4: 110
    x9: 165
  letters: [""]
  font: "monospace"
  chance:
    letter: 0.3
    x9: 0.1
    x4: 0.6
  randomFill: ->
    h = Math.floor Math.random() * 360
    "hsl(" + h + ", 85%, 68%)"
  animation: false