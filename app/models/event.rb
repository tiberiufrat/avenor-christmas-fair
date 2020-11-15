class Event < ApplicationRecord
  belongs_to :admin

  def start_date
    start.strftime('%e %b %Y')
  end

  def end_date
    self.end.strftime('%e %b %Y')
  end

  def start_datetime
    self.start.strftime('%e %b %Y, %k:%M')
  end

  def end_datetime
    self.end.strftime('%e %b %Y, %k:%M')
  end

  def start_time
    start.strftime('%k:%M')
  end

  def end_time
    self.end.strftime('%k:%M')
  end
end
