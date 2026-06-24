WITH songs AS (
    SELECT * FROM {{ ref('stg_spotify_songs') }}
),

listening AS (
    SELECT * FROM {{ ref('stg_spotify_listening_data') }}
)

SELECT
    l.song_id,
    s.artist_name,
    s.title,
    s.genre,
    l.listen_date,
    l.minutes_listened
FROM listening l
INNER JOIN songs s
    ON l.song_id = s.song_id
-- Syntaxe BigQuery pour filtrer sur les 2 dernières années :
WHERE l.listen_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR)