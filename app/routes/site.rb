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

    def markdown_in_haml(template, options = {}, locals = {})
      haml(:layout, :layout => false) do
        options[:layout] = false
        markdown(template, options, locals)
      end
    end
  end

  get "/" do
    markdown_in_haml :home
  end

  get "/contribute" do
    markdown_in_haml :contribute
  end

  get "/structure" do
    markdown_in_haml :structure
  end

  get "/structure/:component" do |component|
    markdown_in_haml :"structure/#{component}"
  end

  get "/dependencies" do
    markdown_in_haml :dependencies
  end

  get "/skeletons" do
    markdown_in_haml :skeletons
  end

  get "/help/:page" do |page|
    markdown_in_haml :"help/#{page}"
  end
end
