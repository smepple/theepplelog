module ApplicationHelper

  def full_title(page_title)
    base_title = "the epplelog"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, no_intra_emphasis: true, fenced_code_blocks: true, autolink: true)
    markdown.render(text).html_safe
  end
end
