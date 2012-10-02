$ ->

  @text_utils = new TextUtils()
  $container = $(".container")

  # slit each word in to spans
  spans = @text_utils.split_to_elements($container.html())
  spans = $container.html(spans).children()

  # group spans by top offset (lines)
  groups = _.groupBy spans, (span) -> $(span).offset().top
    

  # convert grouped object to array 
  chunk_lines = _.toArray groups
  # remove spans and flatten lines

  # loop through array of spans grouped in to lines
  # move words in to new line div and ditch spans.
  lines = []
  for _line in chunk_lines
    line_words = ""
    line_words += word.innerHTML for word in _line
    lines.push "<div class='line'>#{line_words}</div>"

  $container.html lines
  
  
  # animate each line in
  $(".line").each (i,line) ->
    $(@).css
      position: "absolute"
      top: i * $(@).height()

    TweenMax.from $(line), 1.4
      css:
        top: "+=50"
        rotation: 50
        opacity: 0
      delay: i*.04
      ease: Quint.easeInOut

    

  
    

    
  
