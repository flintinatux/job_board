atom_feed id: "urn:uuid:#{(@category || @current_board).uuid}" do |feed|
  feed.title @category ? "#{@category.name} Jobs" : @current_board.title
  feed.updated @jobs.first.created_at
  feed.rights "#{@current_board.title} © #{Date.today.year}. All Rights Reserved."

  @jobs.each do |job|
    feed.entry job, id: "urn:uuid:#{job.uuid}", published: job.created_at do |entry|
      entry.title job.title
      entry.content type: 'html' do |content|
        body = <<-HTML
          <p>
            <strong>#{job.location}</strong><br />
            <strong>URL:</strong> <a href="#{job.url}">#{job.url}</a>
          </p>
          #{$markdown.render job.description}
          <p><strong>To apply:</strong></p>
          #{$markdown.render job.instructions}
        HTML
        content.cdata! body.html_safe
      end
    end
  end
end
