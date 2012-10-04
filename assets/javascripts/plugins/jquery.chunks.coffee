#  * jQuery Chunks. Blow them.
#  * A plugin for splitting chunks of elements and animating them.
#  * Originally intented for converting a paragraph to 
#  * invidiaul lines and animating them.

#  * Licensed under the MIT license.
#  * Copyright 2012 Bad Assembly

#  * Dependencies:
#
#     * Underscore.js
#     * jQuery

( ($) ->
  $.extend $.fn, chunks: (options) ->
    @default_options =
      lines: false
    # make settings obj from default options combined with options
    settings = $.extend({}, @default_options, options)
    if settings.lines is false then overflow = false
    # log settings

    @to_words = =>
      separator = settings.separator or " "
      tag_name = settings.tag_name or "span"
      # store original source
      # to be recreated. on resize.
      # if @.data "source"
      #   @.html @.data "source"
      # else
      #   @.data "source", @.html()

      # to do: make this work for multiple paragraphs in target div
      html = ""
      items = $(@$el).html().split(separator)
      _.each items, (word, i) =>
        spacer = if i < items.length - 1 then " " else ""
        html += "<#{tag_name}>#{word}#{spacer}</#{tag_name}>"
      @words = $(this).html(html).children()

    @to_lines = =>
      # group elements by top offset (lines)
      groups = _.groupBy @words, (element) -> $(element).offset().top

      # convert grouped object to array 
      chunk_lines = _.toArray groups

      # loop through array of elements grouped in to lines
      # move words in to new line div and ditch elements.
      lines = []
      for _line in chunk_lines
        line_words = ""
        line_words += word.innerHTML for word in _line
        if settings.overflow is 'hidden'
          lines.push "<div class='case'><div class='line'>#{line_words}</div></div>"
        else
          lines.push "<div class='line'>#{line_words}</div>"
      $(this).html(lines)

    @set_css = =>
      tag_name = if settings.overflow then '.case' else '.line'
      $(tag_name).each (i,tn) =>
        $(tn).css
          position: "absolute"
          top: i * $(tn).height()
        $(tn).css("overflow", "hidden") if settings.overflow
        switch settings.align
          when 'center'
            line_left = ($(tn).parent().width() - $(tn).width())/2
          when 'right'
            line_left = ($(tn).parent().width() - $(tn).width())
        $(tn).css('left', line_left) if line_left

    @each (i, el) =>
      @$el = $(el)
      @to_words()
      @to_lines() if settings.lines
      @set_css() if settings.lines

  this
) this.jQuery