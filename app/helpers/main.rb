class Main
  helpers do
    def snippet(&block)
      html = capture_haml(&block)
      "<pre><code>#{escape_html html.strip}</pre></code>"
    end
  end
end
