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

$.fn.splitTo = (options={}) ->

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

    # store split to lines/words var
    @split_to_lines = options.split_to_lines
    
    html = ""
    items = $(".source").html().split(separator)
    _.each items, (word, i) =>
      spacer = if i < items.length - 1 then " " else ""
      html += "<span class='casing'><#{tagName}>#{word}#{spacer}</#{tagName}></span>"
    log html
    return html


  split_to_lines = (elements) =>
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
      lines.push "<div class='casing'><div class='line'>#{line_words}</div></div>"

    $(this).html(lines)
    log $(this).html()

  # init_resize() if options.resizable

  source = options.source || ".source"
  $source = $(".source")
  log $source

  # slit each word in to elements
  elements = split_to_elements($source.html(), options)
  elements = $(this).html(elements).children()

  split_to_lines(elements) if @split_to_lines

  this

$.fn.animateLines = (options={}) ->
  log @split_to_lines
  options.duration = .3
  options.stagger ||= 0.3
  options.css ||= {}
  options.delay = .02
  if @split_to_lines
    $(".casing").each (i,line) =>
      $(line).css
        position: "absolute"
        top: i * $(line).height()
        overflow: "hidden"

  # animate each line in
  tl = new TimelineMax(onComplete: options.onComplete)
  tl.stop()
  tl.staggerFrom $(".line"), .4
    css: options.css
    ease: options.ease
    options.stagger
  tl.play()


  return this

