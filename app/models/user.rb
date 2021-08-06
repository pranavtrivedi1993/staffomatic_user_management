class User < ApplicationRecord
  include PublicActivity::Model
  tracked
  has_secure_password

  # Scopes
  scope :archived, -> { where(archived: true) }
  scope :unarchived, -> { where(archived: false) }

  # Validations
  validates :email, presence: true, uniqueness: true

  # Callbacks
  after_save :send_archive_unarchive_email, if: :saved_change_to_archived?
  after_destroy :send_destroy_email

  private

  def send_archive_unarchive_email
    begin
      UserMailer.archive_unarchive_email(self).deliver_now
    rescue => e
      Rails.logger.warn "#{e.inspect}"
    end
  end

  def send_destroy_email
    begin
      UserMailer.destroy_email(self).deliver_now
    rescue => e
      Rails.logger.warn "#{e.inspect}"
    end
  end
end
