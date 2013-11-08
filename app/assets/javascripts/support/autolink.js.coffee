Linker =
  linkRegex:    /(?:((?:http|https|ftp):)\/\/|www\.)[^\s<>\u00A0]+/gi
  linkContext:  [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/gi, /<\/a>/i]
  emailRegex:   /[\w.!#\$%+-]\.?[\w.!#\$%&'*\/=?^`{|}~+-]*@[\w-]+(?:\.[\w-]+)+/
  bracketAtEnd: /[^\w\/-]$/
  brackets:
    ']' : '['
    ')' : '('
    '}' : '{'
    '"' : '"'
    "'" : "'"

  autolink: (text) ->
    @autolinkEmails @autolinkUrls text

  autolinkEmails: (text) ->
    text.replace @emailRegex, (email, offset, string) =>
      left  = string.slice 0, offset
      right = string.slice offset + email.length

      return email if @autolinked left, right
      @linkTo @encode(email), @encode("mailto:#{email}")

  autolinkUrls: (text) ->
    text.replace @linkRegex, (href, scheme, offset, string) =>
      punctuation = []
      left  = string.slice 0, offset
      right = string.slice offset + href.length

      return href if @autolinked left, right

      # don't include trailing punctuation as part of url
      while @bracketAtEnd.test href
        href = href.replace @bracketAtEnd, (bracket) -> punctuation.push bracket; ''
        opening = @brackets[_.last(punctuation)]
        if opening and (href.indexOf(opening) > href.indexOf(_.last(punctuation)))
          href += punctuation.pop()
          break

      linkText = href
      href = 'http://' + href unless scheme
      @linkTo(linkText, href) + punctuation.reverse().join('')

  autolinked: (left, right) ->
    true if @insideTag(left, right) or @betweenTags(left)

  betweenTags: (left) ->
    while (match = @linkContext[2].exec(left))?
      index = @linkContext[2].lastIndex
    return false unless index
    right = left.slice index
    ! @linkContext[3].test right

  encode: (email) ->
    _.map(email.split(''), (char) -> "&##{char.charCodeAt(0)};").join ''

  insideTag: (left, right) ->
    true if @linkContext[0].test(left) and @linkContext[1].test(right)

  linkTo: (text, href) ->
    "<a href=\"#{href}\">#{text}</a>"

autolink = (text) -> Linker.autolink text

if typeof exports == 'object'
  module.exports = autolink
else if typeof define == 'function' && define.amd
  define () -> autolink
else
  @autolink = autolink
