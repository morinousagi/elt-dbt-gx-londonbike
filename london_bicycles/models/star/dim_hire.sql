SELECT DISTINCT
    rental_id, 
    duration, 
    --duration_ms, 
    bike_id, 
    --bike_model, 
    end_date, 
    --end_station_id, 
    end_station_name, 
    start_date, 
    --start_station_id, 
    start_station_name, 
    end_station_logical_terminal, 
    start_station_logical_terminal, 
    end_station_priority_id

FROM {{ source('london_bicycles', 'cycle_hire') }}

--WHERE start_date >= TIMESTAMP('2021-01-01 00:00:00 UTC')
