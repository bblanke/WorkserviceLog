json.array!(@timecards) do |timecard|
  json.extract! timecard, :id, :timein, :timeout, :user_id
  json.url timecard_url(timecard, format: :json)
end
