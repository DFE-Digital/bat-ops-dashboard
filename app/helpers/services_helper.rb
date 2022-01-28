require_relative '../../lib/github'

module ServicesHelper
  def colour_for_status(status)
    colors = {
      'success' => 'green',
      'in_progress' => 'blue',
      'queued' => 'yellow',
      'failure' => 'red'
    }

    colors[status].nil? ? 'grey' : colors[status]
  end

  def production?(environment)
    environment == 'production'
  end

  def format_time(time)
    DateTime.strptime("#{time} UTC",
                      '%m/%d/%Y %H:%M%p %Z').in_time_zone('Europe/London').strftime('%l:%M%P on %A %e %b %Y')
  end
end
