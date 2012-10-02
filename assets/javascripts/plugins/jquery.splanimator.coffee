#  * jQuery Splanimator. (Splitter & Animator)
#  * A plugin for splitting chunks of elements and animating them.
#  * Originally intented for converting a paragraph to 
#  * invidiaul lines and animating them.

#  * Licensed under the MIT license.
#  * Copyright 2012 Scott Baggett

$.fn.splitToLines = (options={}) ->

  split_to_elements = (copy, options={}) =>
    separator = options.separator or " "
    tagName = options.tagName or "span"
    html = ""
    items = $source.html().split(separator)
    _.each items, (word, i) =>
      spacer = if i < items.length - 1 then " " else ""
      html += "<#{tagName}>#{word}#{spacer}</#{tagName}>"
    log html
    return html



  source = options.source || ".source"
  $source = $(source, this)

  # slit each word in to elements
  elements = split_to_elements($source.html())
  elements = $(this).html(elements).children()

  # group elements by top offset (lines)
  groups = _.groupBy elements, (element) -> $(element).offset().top

  # convert grouped object to array 
  chunk_lines = _.toArray groups
  
  # loop through array of elements grouped in to lines
  # move words in to new line div and ditch elements.
  lines = []
  for _line in chunk_lines
    line_words = ""
    line_words += word.innerHTML for word in _line
    lines.push "<div class='line'>#{line_words}</div>"

  $(this).html(lines)

  this

$.fn.animateLines = (options={}) ->
    
    # animate each line in
    $(".line").each (i,line) ->
      $(@).css
        position: "absolute"
        top: i * $(@).height()

      TweenMax.from $(line), .24
        css:
          top: "+=35"
          opacity: 0
          scale: .3
        delay: i*.055
        ease: Back.easeOut

    this
