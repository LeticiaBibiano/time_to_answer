class TopicForm
  include ActiveAttr::Model

  attribute :topic_id
  attribute :initial_date
  attribute :final_date


  validate :validate_initial_date
  validate :validate_final_date

  private

  def validate_initial_date
    initial_date.present? && initial_date.to_date
  rescue ArgumentError
    errors.add(:initial_date, :invalid)
  end

  def validate_final_date
    final_date.present? && final_date.to_date
  rescue ArgumentError
    errors.add(:final_date, :invalid)
  end
end
