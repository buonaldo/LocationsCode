CREATE FUNCTION dbo.fn_EncodeLocationCode (@lat FLOAT, @lon FLOAT)
RETURNS VARCHAR(50)
AS
BEGIN
    -- 1) Controllo validità
    IF @lat < -90 OR @lat > 90 OR @lon < -180 OR @lon > 180
        RETURN NULL;

    DECLARE @alphabet CHAR(34) = '23456789ABCDEFGHJKLMNPQRSTUVWXYZ';
    DECLARE @latSec BIGINT, @lonSec BIGINT;
    DECLARE @latCode VARCHAR(10) = '', @lonCode VARCHAR(10) = '';
    DECLARE @combined VARCHAR(50) = '', @result VARCHAR(50) = '';
    DECLARE @i INT = 1, @val BIGINT, @p_base BIGINT, @b INT;

    -- 2) Arcosecondi
    SET @latSec = ROUND((@lat + 90) * 3600, 0);
    SET @lonSec = ROUND((@lon + 180) * 3600, 0);

    -- 3) Conversione Base34 Latitudine
    SET @val = @latSec;
    SET @b = 3;
    WHILE @b >= 0
    BEGIN
        SET @p_base = POWER(CAST(34 AS BIGINT), @b);
        SET @latCode = @latCode + SUBSTRING(@alphabet, CAST(FLOOR(@val / @p_base) AS INT) + 1, 1);
        SET @val = @val % @p_base;
        SET @b = @b - 1;
    END

    -- 4) Conversione Base34 Longitudine
    SET @val = @lonSec;
    SET @b = 3;
    WHILE @b >= 0
    BEGIN
        SET @p_base = POWER(CAST(34 AS BIGINT), @b);
        SET @lonCode = @lonCode + SUBSTRING(@alphabet, CAST(FLOOR(@val / @p_base) AS INT) + 1, 1);
        SET @val = @val % @p_base;
        SET @b = @b - 1;
    END

    -- 5) Interleaving
    DECLARE @maxLen INT = CASE WHEN LEN(@latCode) > LEN(@lonCode) THEN LEN(@latCode) ELSE LEN(@lonCode) END;
    WHILE @i <= @maxLen
    BEGIN
        IF @i <= LEN(@latCode) SET @combined = @combined + SUBSTRING(@latCode, @i, 1);
        IF @i <= LEN(@lonCode) SET @combined = @combined + SUBSTRING(@lonCode, @i, 1);
        SET @i = @i + 1;
    END

    -- 6) Risultato con trattino
    DECLARE @mid INT = CEILING(CAST(LEN(@combined) AS FLOAT) / 2);
    SET @result = LEFT(@combined, @mid) + '-' + SUBSTRING(@combined, @mid + 1, LEN(@combined));

    RETURN @result;
END;
