#  * jQuery Splanimator. (Splitter & Animator)
#  * A plugin for splitting chunks of elements and animating them.
#  * Originally intented for converting a paragraph to 
#  * invidiaul lines and animating them.

#  * Licensed under the MIT license.
#  * Copyright 2012 Scott Baggett

#  * Dependencies:
#
#     * Response.js 
#     * Underscore.js
#     * jQuery

$.fn.splitToLines = (options={}) ->

  # Response.action ->
    # split_to_elements()

  split_to_elements = (copy, options={}) =>

    separator = options.separator or " "
    tagName = options.tagName or "span"

    # store original source
    # to be recreated. on resize.
    
    if @.data "source"
      @.html @.data "source"
    else
      @.data "source", @.html()
    
    html = ""
    items = $(".source").html().split(separator)
    _.each items, (word, i) =>
      spacer = if i < items.length - 1 then " " else ""
      html += "<#{tagName}>#{word}#{spacer}</#{tagName}>"
    # log html
    return html

  # init_resize() if options.resizable

  source = options.source || ".source"
  $source = $(".source")
  log $source

  # slit each word in to elements
  elements = split_to_elements($source.html(), options)
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
  options.duration = .3
  options.stagger ||= 0.3
  options.css ||= {}
  options.delay = .02
  $(".line").each (i,line) =>
    $(line).css
      position: "absolute"
      top: i * $(line).height()

  # animate each line in
  tl = new TimelineMax(onComplete: options.onComplete)
  tl.stop()
  tl.staggerFrom $(".line"), .4
    css: options.css
    ease: options.ease
    options.stagger
  tl.play() if options.autoplay




  return this

