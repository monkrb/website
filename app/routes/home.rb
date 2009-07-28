require "maruku"

class Main
  helpers do
    def lookup_layout(engine, template, views_dir)
      super(:haml, template, views_dir)
    end

    def markdown(template, options={}, locals={})
      render :markdown, template, options, locals
    end

    def render_markdown(template, data, options, locals, &block)
      ::Maruku.new(data).to_html
    end
  end

  get "/" do
    haml :home
  end

  get "/contribute" do
    haml(:layout, :layout => false) do
      markdown :contribute, :layout => false
    end
  end
end
