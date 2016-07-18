require_relative './helper'
require_relative './settings'

handler do |job|
  toggl_job(job)
end

@job_days.each do |day|
  # 定期的メッセージ起動ジョブ
  @regular_times.each.with_index do |time, i|
    eval %Q!every(1.week, :regular_#{day}_#{i}, at: "#{day} #{time}") { toggl_job(:regular) }!
  end
  # 朝のメッセージ起動ジョブ
  eval %Q!every(1.week, :morning_#{day},     at: "#{day} #{@morning_time}")     { toggl_job(:morning) }!
  # お昼休みメッセージ起動ジョブ
  eval %Q!every(1.week, :noon_#{day},        at: "#{day} #{@noon_time}")        { toggl_job(:noon) }!
  # お昼休み終了メッセージ起動ジョブ
  eval %Q!every(1.week, :after_noon_#{day},  at: "#{day} #{@after_noon_time}")  { toggl_job(:after_noon) }!
  # 業務終了メッセージ起動ジョブ
  eval %Q!every(1.week, :night_#{day},       at: "#{day} #{@night_time}")       { toggl_job(:morning) }!
  # 日報作成起動ジョブ
  eval %Q!every(1.week, :dailyreport_#{day}, at: "#{day} #{@dailyreport_time}") { toggl_job(:morning) }!
end

every(1.minutes, :test) do
  toggl_job(:morning)
end
