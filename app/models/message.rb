class Message < ApplicationRecord
  belongs_to :message_group

  validate :no_empty_message
  has_many_attached :attachments, dependent: :destroy

  private

    def no_empty_message
      errors.add(:content, "Mensagem não pode ser vazia") if content.empty? && attachments.count.zero?
    end
end
