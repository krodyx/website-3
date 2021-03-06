###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Internationalization
activate :i18n, :mount_at_root => :en

# Easy
activate :autoprefixer

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def home_url
    if I18n.locale.to_s != 'en' then "/#{I18n.locale}/" else "/" end
  end
  def contact_form_iframe_url
    ENV.fetch("SWB_CONTACT_FORM_URL", "//localhost:5000/%{locale}/contact/form") % { locale: I18n.locale }
  end
  def volunteer_form_iframe_url
    ENV.fetch("SWB_VOLUNTEER_FORM_URL", "//localhost:5000/%{locale}/recruit/form") % { locale: I18n.locale }
  end
  def trimmed_locales
    locales_list.each do |locale|
      locale.slice! ".yml"
    end
  end
  def locales_list
    Dir.glob("locales/*.yml").each do |file|
      file.slice! "locales/"
    end
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css
  activate :minify_html
  
  # Minify Javascript on build
  # activate :minify_javascript

  # Generate favicons
  activate :favicon_maker do |f|
    # template_dir doesn't work in 4.0 as per https://github.com/follmann/middleman-favicon-maker/issues/42
    # f.template_dir  = 'source/images'
    f.icons = {
      # Hack: instead specify directory in filename
      "images/_favicon_template.svg" => [
        # Only generate small icons since the original is of too low
        # quality for higher resolutions.
        { icon: "favicon.png", size: "16x16" },
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      ]
    }
  end
end
