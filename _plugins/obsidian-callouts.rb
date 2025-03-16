# frozen_string_literal: true

Jekyll::Hooks.register :documents, :pre_render do |doc|
  if doc.collection && doc.collection.label == "notes"
    process_blockquotes(doc)
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  process_blockquotes(page)
end

def process_blockquotes(doc)
  return unless doc.respond_to?(:content) && doc.content.is_a?(String)

  puts "Processing: #{doc.path}" # Debug output

  # Split the content into lines for line-by-line processing
  lines = doc.content.split("\n")
  new_lines = []
  i = 0

  # Get the markdown converter from the site (this uses whichever is configured, not necessarily kramdown)
  converter = doc.site.find_converter_instance(Jekyll::Converters::Markdown)

  while i < lines.size
    # Look for the start of a callout block matching:
    #   > [!TYPE] TITLE
    if lines[i] =~ /^> \[!(\w+)\] (.*)/
      type = $1.downcase
      title = $2.strip

      callout_lines = []  # To collect callout content lines
      i += 1
      # Gather any subsequent lines that begin with "> "
      while i < lines.size && lines[i] =~ /^> /
        callout_lines << lines[i].sub(/^> /, '')
        i += 1
      end

      # Join the collected lines (if any)
      callout_content = callout_lines.join("\n").strip

      # Convert the title using the markdown converter, then remove wrapping <p> tags if present
      converted_title = converter.convert(title).strip
      converted_title = converted_title.sub(/^<p>/, '').sub(%r{</p>$}, '')

      # Convert the callout content (if any) to HTML
      converted_content = converter.convert(callout_content).strip unless callout_content.empty?

      # Build the HTML block for the callout.
      new_lines << <<~HTML.chomp
        <blockquote class="callout" data-callout="#{type}">
          <div class="callout-title-wrapper">
            <span class="callout-icon"></span>
            <div class="callout-title">#{converted_title}</div>
          </div>
          #{ callout_content.empty? ? "" : "<div class=\"callout-content\">#{converted_content}</div>" }
        </blockquote>
      HTML

    else
      # For non-callout lines, just copy them over.
      new_lines << lines[i]
      i += 1
    end
  end

  # Reassemble the document content.
  doc.content = new_lines.join("\n")
end
