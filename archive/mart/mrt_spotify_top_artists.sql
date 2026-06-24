{{ config(
    materialized='table'
) }}

WITH song_listening AS (
    SELECT * FROM {{ ref('int_spotify_song_listening') }}
)

SELECT
    artist_name,
    SUM(minutes_listened) AS total_minutes_listened
FROM song_listening
GROUP BY
    artist_name
ORDER BY
    total_minutes_listened DESC
LIMIT 20