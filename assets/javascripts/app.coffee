$ ->

  $copy = $(".container").first()
  .splitToLines(
    resizable: true
  )
  .animateLines(
    css:
      top: "+=30"
      opacity: 0

    duration: .4
    ease: Quint.easeOut
    stagger: .03
    autoplay: true
    onComplete: ->
      log "in complete."
  )

  window.container = $copy
