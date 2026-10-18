#!/bin/bash
for script in stargate_unified_macro.sql stargate_bloomberg_report.sql stargate_bloomberg_deltadashboard3.sql stargate_bloomberg_openinterest.sql stargate_bloomberg_openinterest1.sql stargate_bloomberg_openinterest2.sql; do
    echo "=== Executing: $script ==="
    sudo docker exec -i sql2025 /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "BloombergOpen2026!" -d master -C < "$script"
    echo ""
done
