module AwesomeShareButtons
  class << self
    attr_accessor :config
    def configure
      yield self.config ||= Config.new
    end
  end

  class Config
    # enable social sites to share,
    # * default : twitter facebook weibo douban
    # * site support: twitter facebook weibo douban
    attr_accessor :allow_sites, :social_pages

    def initialize
    end
  end
end
