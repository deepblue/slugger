# For mephisto-themes compatibilities
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update \
  :standard  => '%B %d, %Y @ %I:%M %p',
  :stub      => '%B %d',
  :time_only => '%I:%M %p',
  :plain     => '%B %d %I:%M %p',
  :mdy       => '%B %d, %Y',
  :my        => '%B %Y'

module ActiveSupport::CoreExtensions::Time::Conversions
  def to_ordinalized_s(format = :default)
    format = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[format] 
    return to_default_s if format.nil?
    strftime(format.gsub(/%d/, '_%d_')).gsub(/_(\d+)_/) { |s| s.to_i.ordinalize }
  end
end
