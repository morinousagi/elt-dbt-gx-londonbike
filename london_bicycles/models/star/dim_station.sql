SELECT DISTINCT
    id, 
    --installed, 
    latitude, 
    --locked, 
    longitude, 
    name, 
    bikes_count, 
    docks_count, 
    nbEmptyDocks, 
    --temporary, 
    terminal_name, 
    install_date, 
    --removal_date

    (SELECT COUNT(h.start_station_id)
     FROM {{ source('london_bicycles', 'cycle_hire') }} AS h
     WHERE s.id = h.start_station_id
     --AND h.start_date >= TIMESTAMP('2021-01-01 00:00:00 UTC')
     ) AS start_total,   -- total no. of starts at this station

    (SELECT COUNT(h.end_station_id)
     FROM {{ source('london_bicycles', 'cycle_hire') }} AS h
     WHERE s.id = h.end_station_id
     --AND h.start_date >= TIMESTAMP('2022-01-01 00:00:00 UTC')
     ) AS end_total   -- total no. of ends at this station


FROM {{ source('london_bicycles', 'cycle_stations') }} AS s