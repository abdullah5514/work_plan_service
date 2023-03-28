FactoryBot.define do
    factory :shift do
      start_time { "2023-04-01 08:00:00" }
      end_time { "2023-04-01 16:00:00" }
      worker
    end
  end
  