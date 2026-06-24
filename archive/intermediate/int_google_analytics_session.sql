WITH events AS (
    SELECT *
    FROM {{ ref('stg_google_analytics_events') }} -- Remplace par le nom exact de ton modèle de staging
)

SELECT
    unique_session_id,                                    -- [cite: 37]
    user_pseudo_id,                                       -- [cite: 38]
    
    -- Calcul des temps de session
    MIN(event_timestamp) AS session_start_time,           -- [cite: 39]
    MAX(event_timestamp) AS session_end_time,             -- [cite: 40]
    
    -- La syntaxe de différence de date dépend de ton Data Warehouse (BigQuery, Snowflake, etc.)
    -- Exemple pour BigQuery :
    TIMESTAMP_DIFF(MAX(event_timestamp), MIN(event_timestamp), SECOND) AS session_duration_seconds, -- [cite: 41]

    -- Informations de navigation (généralement constantes sur une session, MAX() permet de les récupérer)
    MAX(browser) AS browser_used,                         -- [cite: 42] Adapté si ta colonne source s'appelle 'browser'
    MAX(traffic_medium) AS traffic_medium,                -- [cite: 43]
    MAX(traffic_source) AS traffic_source,                -- [cite: 44]
    MAX(traffic_name) AS traffic_name,                    -- [cite: 45]

    -- Comptage des événements
    COUNT(event_name) AS event_count,                     -- [cite: 46]
    COUNT(CASE WHEN event_name = 'page_view' THEN 1 END) AS pages_viewed -- [cite: 47]

FROM events
GROUP BY 
    unique_session_id,
    user_pseudo_id