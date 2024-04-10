class Image < ApplicationRecord
  has_one_attached :file
  has_and_belongs_to_many :tags
  belongs_to :user

  after_commit :generate_tags, on: :create

  private

  def generate_tags
    return if self.file.blank?

    gemini_tags = GoogleVertexAi.get_tags_from_image(self.file.download, self.file.blob.content_type)

    if gemini_tags.present? && gemini_tags.is_a?(Array)
      gemini_tags.each do |tag|
        self.tags << Tag.find_or_create_by(name: tag)
      end
    end
  end
end
