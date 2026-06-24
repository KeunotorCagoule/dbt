SELECT
    song_id,
    UPPER(artist) AS artist_name,
    UPPER(title) AS title,
    COALESCE(genre, 'Unknown') AS genre
FROM {{ source('spotify', 'songs') }}