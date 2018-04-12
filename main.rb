require 'json'

def alfred_output(title:, subtitle:, arg:)
  {
    items: [
      {
        title: title,
        subtitle: subtitle,
        arg: arg,
        icon: 'EE90C0AA-97B4-4B4D-8662-CDF405614904.png'
      }
    ]
  }.to_json
end

start_time, end_time, lunch_time = ARGV.map do |time_string|
  hour, min = time_string.split(':')
  {hour: hour.to_i, min: min.to_i}
end

total_time = {
  hour: end_time[:hour] - start_time[:hour],
  min: end_time[:min] - start_time[:min]
}

total_time[:hour] -= lunch_time[:hour]
total_time[:min] -= lunch_time[:min]

while total_time[:min] < 0
  total_time[:hour] -= 1
  total_time[:min] += 60
end

working_time = "%2i:%02i" % [total_time[:hour], total_time[:min]]

print alfred_output(
  title: working_time,
  subtitle: 'Billable hours',
  arg: working_time.strip
)
