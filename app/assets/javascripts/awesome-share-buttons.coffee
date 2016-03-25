window.AwesomeShareButtons =
  openUrl: (url, popup) ->
    if popup == 'true'
      window.open(url,'popup','height=500,width=500')
    else
      window.open(url)
      false

  share: (el) ->
    site = $(el).data('site')
    $parent = if $(el).parent().is 'span' then $(el).parent().parent() else $(el).parent()
    title = encodeURIComponent($parent.data('title') || '')
    img = encodeURIComponent($parent.data('img') || '')
    url = encodeURIComponent($parent.data('url') || '')
    via = encodeURIComponent($parent.data('via') || '')
    desc = encodeURIComponent($parent.data('desc') || '')
    popup = encodeURIComponent($parent.data('popup') || 'false')

    if url.length == 0
      url = encodeURIComponent(location.href)
    switch site
      when 'email'
        location.href = "mailto:?to=&subject=#{title}&body=#{url}"
      when 'twitter'
        via_str = ''
        via_str = "&via=#{via}" if via.length > 0
        AwesomeShareButtons.openUrl("https://twitter.com/intent/tweet?url=#{url}&text=#{title}#{via_str}",popup)
      when 'facebook'
        AwesomeShareButtons.openUrl("http://www.facebook.com/sharer.php?u=#{url}", popup)
      when 'vk'
        AwesomeShareButtons.openUrl("http://vk.com/share.php?url=#{url}", popup)
      when 'google_plus'
        AwesomeShareButtons.openUrl("https://plus.google.com/share?url=#{url}", popup)
      when 'delicious'
        AwesomeShareButtons.openUrl("http://www.delicious.com/save?url=#{url}&title=#{title}&jump=yes&pic=#{img}", popup)
      when 'pinterest'
        AwesomeShareButtons.openUrl("http://www.pinterest.com/pin/create/button/?url=#{url}&media=#{img}&description=#{title}", popup)
      when 'tumblr'
        get_tumblr_extra = (param) ->
          cutom_data = $(el).attr("data-#{param}")
          encodeURIComponent(cutom_data) if cutom_data

        tumblr_params = ->
          path = get_tumblr_extra('type') || 'link'

          params = switch path
            when 'text'
              title = get_tumblr_extra('title') || title
              "title=#{title}"
            when 'photo'
              title = get_tumblr_extra('caption') || title
              source = get_tumblr_extra('source') || img
              "caption=#{title}&source=#{source}"
            when 'quote'
              quote = get_tumblr_extra('quote') || title
              source = get_tumblr_extra('source') || ''
              "quote=#{quote}&source=#{source}"
            else # actually, it's a link clause
              title = get_tumblr_extra('title') || title
              url = get_tumblr_extra('url') || url
              "name=#{title}&url=#{url}"


          "/#{path}?#{params}"

        AwesomeShareButtons.openUrl("http://www.tumblr.com/share#{tumblr_params()}", popup)
    false
