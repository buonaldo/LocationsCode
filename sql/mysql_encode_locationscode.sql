DELIMITER $$

CREATE FUNCTION encodeLocationCode(lat DOUBLE, lon DOUBLE)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    -- Alfabeto personalizzato
    DECLARE alphabet CHAR(34) DEFAULT '23456789ABCDEFGHJKLMNPQRSTUVWXYZ';
    DECLARE latSec, lonSec BIGINT;
    DECLARE latCode, lonCode VARCHAR(10) DEFAULT '';
    DECLARE combined, result VARCHAR(50) DEFAULT '';
    DECLARE i, maxLen, mid INT;
    DECLARE val, p_base BIGINT;
    DECLARE b INT;

    -- 1) Controllo validità: restituisce NULL se fuori range
    IF lat < -90 OR lat > 90 OR lon < -180 OR lon > 180 THEN
        RETURN NULL;
    END IF;

    -- 2) Converte in arcosecondi (aggiungendo l'offset per eliminare i negativi)
    SET latSec = ROUND((lat + 90) * 3600);
    SET lonSec = ROUND((lon + 180) * 3600);

    -- 3) Conversione Base34 per Latitudine
    SET val = latSec;
    SET b = 3;
    WHILE b >= 0 DO
        SET p_base = FLOOR(POW(34, b));
        SET latCode = CONCAT(latCode, SUBSTRING(alphabet, FLOOR(val / p_base) + 1, 1));
        SET val = val % p_base;
        SET b = b - 1;
    END WHILE;

    -- 4) Conversione Base34 per Longitudine
    SET val = lonSec;
    SET b = 3;
    WHILE b >= 0 DO
        SET p_base = FLOOR(POW(34, b));
        SET lonCode = CONCAT(lonCode, SUBSTRING(alphabet, FLOOR(val / p_base) + 1, 1));
        SET val = val % p_base;
        SET b = b - 1;
    END WHILE;

    -- 5) Interleaving (alternanza caratteri)
    SET i = 1;
    SET maxLen = GREATEST(CHAR_LENGTH(latCode), CHAR_LENGTH(lonCode));
    WHILE i <= maxLen DO
        IF i <= CHAR_LENGTH(latCode) THEN SET combined = CONCAT(combined, SUBSTRING(latCode, i, 1)); END IF;
        IF i <= CHAR_LENGTH(lonCode) THEN SET combined = CONCAT(combined, SUBSTRING(lonCode, i, 1)); END IF;
        SET i = i + 1;
    END WHILE;

    -- 6) Formattazione finale con trattino
    SET mid = CEIL(CHAR_LENGTH(combined) / 2);
    SET result = CONCAT(SUBSTRING(combined, 1, mid), '-', SUBSTRING(combined, mid + 1));

    RETURN result;
END$$

DELIMITER ;

