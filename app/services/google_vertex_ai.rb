class GoogleVertexAi
  def self.get_tags_from_image(image_file, content_type)
    # Set up a Gemini client to query the Vertex AI API
    client = Gemini.new(
      credentials: { service: 'vertex-ai-api', region: 'asia-southeast1', file_path: Rails.root.join('google-credentials.json').to_s, project_id: 'bowerbird-technical-test' },
      options: { model: 'gemini-pro-vision', server_sent_events: true }
    )

    result = client.stream_generate_content(
      { contents: [
                    { role: 'user', parts: [
                      { text: 'Describe this image as a series of nouns separate by space (no more than 10 nouns).' },
                      { inline_data: {
                        mime_type: content_type,
                        data: Base64.strict_encode64(image_file)
                      } }
                    ] }
                  ] }
    )

    tags = nil

    if result.dig(0, 'candidates').present?
      tags = result[0]['candidates'][0]['content']['parts'][0]['text']
      tags = tags.split(' ').map(&:capitalize).uniq
    end

    tags
  end
end
