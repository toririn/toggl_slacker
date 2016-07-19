require_relative './helper'
require_relative './settings'
require_relative './job'

handler do |job|
  toggl_job(job)
end

@job_days.each do |day|
  # 定期的メッセージ起動ジョブ
  @regular_times.each.with_index do |time, i|
    eval %Q!every(1.week, :regular_#{day}_#{i}, tz: "Tokyo", at: "#{day} #{time}") { toggl_job(:regular) }!
  end
  # 朝のメッセージ起動ジョブ
  eval %Q!every(1.week, :morning_#{day},     tz: "Tokyo", at: "#{day} #{@morning_time}")     { toggl_job(:morning) }!
  # お昼休みメッセージ起動ジョブ
  eval %Q!every(1.week, :noon_#{day},        tz: "Tokyo", at: "#{day} #{@noon_time}")        { toggl_job(:noon) }!
  # お昼休み終了メッセージ起動ジョブ
  eval %Q!every(1.week, :after_noon_#{day},  tz: "Tokyo", at: "#{day} #{@after_noon_time}")  { toggl_job(:after_noon) }!
  # 業務終了メッセージ起動ジョブ
  eval %Q!every(1.week, :night_#{day},       tz: "Tokyo", at: "#{day} #{@night_time}")       { toggl_job(:night) }!
  # 日報作成起動ジョブ
  eval %Q!every(1.week, :dailyreport_#{day}, tz: "Tokyo", at: "#{day} #{@dailyreport_time}") { toggl_job(:dailyreport) }!
end
