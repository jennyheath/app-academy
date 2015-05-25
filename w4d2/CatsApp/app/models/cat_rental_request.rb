class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"]}
  validate :no_overlapping_approved_requests

  belongs_to :cat
  after_initialize :ensure_status

  def approve!
    raise "not pending" unless self.status == "PENDING"
    CatRentalRequest.transaction do
      self.update(status: "APPROVED")

      overlapping_pending_requests.each { |pending_request| pending_request.deny! }
    end
  end

  def deny!
    self.update(status: "DENIED")
  end

  def overlapping_requests
    cat = Cat.find(cat_id)

    cat.cat_rental_requests
      # .where("(:id )")
      .where(
        "((start_date BETWEEN :s AND :e) OR
        (end_date BETWEEN :s AND :e)) OR
        (start_date < :s AND end_date > :e)",
        {:s => start_date, :e => end_date}
      )
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == "APPROVED"}
  end

  def overlapping_pending_requests
    overlapping_requests.select { |request| request.status == "PENDING"}
  end

  def no_overlapping_approved_requests
    unless overlapping_approved_requests.empty?
      errors[:overlapping_requests] << "Cannot be approved"
    end
  end

  def start_must_come_before_end
    return if start_date < end_date
    errors[:start_date] << "must come before end date"
    errors[:end_date] << "must come after start date"
  end

  private

  def ensure_status
    self.status ||= "PENDING"
  end
end
