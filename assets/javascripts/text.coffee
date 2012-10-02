class @TextUtils

  split_to_elements: (copy, options={}) =>
    separator = options.separator or " "
    tagName = options.tagName or "span"
    html = ""
    items = copy.split(separator)
    _.each items, (word, i) =>
      spacer = if i < items.length - 1 then " " else ""
      html += "<#{tagName}>#{word}#{spacer}</#{tagName}>"
    return html

  fix_position_for: (el) =>
    log $(el).offset()
    offset = $(el).offset()
    log offset
    $(el).position
      position: "absolute"
      top: offset.top
      left: offset.left


      
    

