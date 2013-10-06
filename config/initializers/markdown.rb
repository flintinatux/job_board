renderer = Redcarpet::Render::HTML.new(
    no_styles: true,
    safe_links_only: true
  )

$markdown = Redcarpet::Markdown.new(
    renderer,
    autolink: true,
    no_intra_emphasis: true,
    superscript: true
  )
