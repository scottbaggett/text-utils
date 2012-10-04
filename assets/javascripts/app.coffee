$ ->

  $copy = $(".container").first()
  .splitTo(
    split_to_lines: true
    resizable: true
  )
  .animateLines(
    css:
      top: "+=60"

    duration: .5
    ease: Power2.easeIn
    stagger: .1
    onComplete: ->
      log "in complete."
  )

  window.container = $copy
