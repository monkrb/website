class Main
  helpers do
    def snippet(&block)
      html = capture_haml(&block)
      "<pre><code>#{escape_html html.strip}</pre></code>"
    end

    def navigation(links)
      current = links.index(links.sort_by { |url,text| - url.size }.detect { |url,text| request.path_info =~ /^#{url}/ })

      haml_tag(:ul) do
        links.each_with_index do |(url, text), i|
          css = []
          css << "first" if i == 0
          css << "last" if i == links.size - 1
          css << "current" if i == current

          haml_tag(:li, :class => css.join(" ")) do
            haml_tag(:a, text, :href => url)
          end
        end
      end
    end

    def google_analytics(code)
      <<-EOS
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("#{code}");
pageTracker._trackPageview();
} catch(err) {}</script>
      EOS
    end

    def lloogg(code)
      <<-EOS
<script type="text/javascript">
lloogg_clientid = "#{code}";
</script>
<script type="text/javascript" src="http://lloogg.com/l.js?c=#{code}">
</script>
      EOS
    end
  end
end
