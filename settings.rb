@job_days         = parse_days(ENV['JOB_KICK_DAYS'])
@regular_times    = parse_regular_times(ENV['JOB_KICK_REGULAR_TIMES'])
@morning_time     = ENV['JOB_KICK_MORNING_TIME']     || "09:00"
@noon_time        = ENV['JOB_KICK_NOON_TIME']        || "12:00"
@after_noon_time  = ENV['JOB_KICK_AFTER_NOON_TIME']  || "13:00"
@night_time       = ENV['JOB_KICK_NIGHT_TIME']       || "17:59"
@dailyreport_time = ENV['JOB_KICK_DAILYREPORT_TIME'] || "18:00"
