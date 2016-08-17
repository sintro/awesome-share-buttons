# coding: utf-8
module AwesomeShareButtons
  module Helper
    def awesome_share_buttons(title = '', opts = {})
      extra_data = {}
      rel = opts[:rel]
      html = []
      html << "<div class='awesome-share-buttons' data-title='#{h title}' data-img='#{opts[:image]}' "
      html << "data-url='#{opts[:url]}' data-desc='#{opts[:desc]}' data-popup='#{opts[:popup]}' data-via='#{opts[:via]}'>"

      AwesomeShareButtons.config.allow_sites.each do |name|
        extra_data = opts.select { |k, _| k.to_s.start_with?('data') } if name.eql?('tumblr')

        link_title = t 'awesome_share_buttons.share_to', name: t("awesome_share_buttons.#{name.downcase}")
        html << link_to("<i class='fa fa-#{get_icon(name.downcase)}'></i>".html_safe, '#', {
          rel: ['nofollow', rel],
          'data-site' => name,
          class: "awesome-share-buttons-#{name}",
          onclick: 'return AwesomeShareButtons.share(this);',
          title: h(link_title)
        }.merge(extra_data))
      end

      html << '</div>'
      raw html.join("\n")
    end

    def awesome_social_pages(opts = {})
      extra_data = {}
      rel = opts[:rel]
      html = []
      html << "<div class='awesome-social-pages'>"

      AwesomeShareButtons.config.social_pages.each do |name, url|
        name = name.to_s
        if name == 'rss'
          link_title = t 'awesome_share_buttons.rss_feed'
        else
          link_title = t 'awesome_share_buttons.link_to', name: t("awesome_share_buttons.#{name.downcase}")
        end
        html << link_to("<i class='fa fa-#{get_icon(name.downcase)}'></i>".html_safe, url, {
          class: "awesome-share-buttons-#{name}",
          title: h(link_title)
        }.merge(extra_data))
      end

      html << '</div>'
      raw html.join("\n")
    end

    def get_icon(name)
      case name
        when 'google_plus'
          'google-plus-square'
        when 'email'
          'envelope-square'
        when 'facebook'
          'facebook-square'
        when 'twitter'
          'twitter-square'
        when 'tumblr'
          'tumblr-square'
        when 'pinterest'
          'pinterest-square'
        when 'delicious'
          'delicious'
        when 'vk'
          'vk'
        when 'rss'
          'rss-square'        
        when 'youtube'
          'youtube-square'
        else
          name
      end
    end
  end
end
