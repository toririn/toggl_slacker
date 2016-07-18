def parse_days(days)
  if days.nil?
    return parse_values("Monday, Tuesday, Wednesday, Thursday, Friday")
  else
    parse_values(days)
  end
end

def parse_regular_times(times)
  if times.nil?
    return parse_values("10:00, 11:00, 14:00, 15:00, 16:00, 17:00")
  else
    parse_values(times)
  end
end

def parse_values(val)
  return [] if val.nil?
  val.split(",").map{ |e| e.strip }
end
