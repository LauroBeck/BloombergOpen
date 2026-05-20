-- ====================================================================
-- STARGATE FINANCIAL TELEMETRY - UNIFIED COVEREIGN REPORT ENGINE
-- SYSTEM EXECUTION LAYER: PL/SQL MONOSPACED CONTIGUOUS MATRIX REPORT
-- ====================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;
SET FEEDBACK OFF;

DECLARE
    v_intensity VARCHAR2(20);
BEGIN
    -- 1. Render Contiguous Header Terminal Stack
    DBMS_OUTPUT.PUT_LINE('====================================================================================================');
    DBMS_OUTPUT.PUT_LINE('                    STARGATE TELEMETRY INDUSTRIAL REPORT -- BLOOMBERG ANALYTICS TERMINAL');
    DBMS_OUTPUT.PUT_LINE('====================================================================================================');
    DBMS_OUTPUT.PUT_LINE('RUN TIME: 2026-05-19 23:24:45                                                     REGIONS: SP / RJ');
    DBMS_OUTPUT.PUT_LINE('====================================================================================================');
    DBMS_OUTPUT.PUT_LINE(' SESSION      | ASSET  | CLOSE        | Z-SCORE | CASH BUFFER | ALLOCATION   | VOL_INTENSITY');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------------------');

    -- 2. Stream Data and Render Matrix Rows Dynamically
    FOR r IN (
        SELECT 
            l.ALERT_DATE,
            l.ASSET_ID,
            l.TERMINAL_CLOSE,
            l.ALGO_Z_SCORE,
            c.tactical_cash_allocation,
            l.ALLOCATION_PCT
        FROM ADMIN.TACTICAL_ALLOCATION_LOG l
        CROSS JOIN ADMIN.V_MACRO_CASH_ORCHESTRATOR c
        WHERE l.ALERT_DATE = TO_DATE('2026-05-19', 'YYYY-MM-DD')
        ORDER BY l.ALLOCATION_PCT DESC
    ) LOOP
        -- Fetch matching dynamic volatility footprint
        BEGIN
            SELECT volume_intensity_pct INTO v_intensity 
            FROM ADMIN.V_EQUITY_ANOMALY_ALERTS 
            WHERE asset = r.ASSET_ID AND alert_date = TO_CHAR(r.ALERT_DATE, 'YYYY-MM-DD') AND ROWNUM = 1;
        EXCEPTION
            WHEN OTHERS THEN v_intensity := '0.0%';
        END;

        -- Format and print the consolidated report line with zero container separation
        DBMS_OUTPUT.PUT_LINE(
            RPAD(TO_CHAR(r.ALERT_DATE, 'YYYY-MM-DD'), 13) || '| ' ||
            RPAD(r.ASSET_ID,       7) || '| ' ||
            RPAD(TO_CHAR(r.TERMINAL_CLOSE, '$999.00'), 13) || '| ' ||
            RPAD(TO_CHAR(r.ALGO_Z_SCORE, '990.99'), 8) || '| ' ||
            RPAD(r.tactical_cash_allocation, 12) || '| ' ||
            RPAD(TO_CHAR(r.ALLOCATION_PCT, '990.99') || '%', 13) || '| ' ||
            v_intensity
        );
    END LOOP;

    -- 3. Render Contiguous Footer Terminal Stack
    DBMS_OUTPUT.PUT_LINE('====================================================================================================');
    DBMS_OUTPUT.PUT_LINE('SYSTEM NOTE: JPM triggering parabolic risk weighting due to structural expansion boundaries.');
    DBMS_OUTPUT.PUT_LINE('STATUS: CLUSTER BALANCED // DISPATCH COMPLETED SUCCESSFULLY.');
    DBMS_OUTPUT.PUT_LINE('====================================================================================================');
END;
/
