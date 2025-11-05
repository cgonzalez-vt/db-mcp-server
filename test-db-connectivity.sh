#!/bin/bash

echo "=== Database Connectivity Test ==="
echo ""

# Test local databases
echo "Testing LOCAL databases..."
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@localhost:54322/postgres" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ iai_local (port 54322)" || echo "✗ iai_local (port 54322) - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@localhost:5432/transaction_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ts_local" || echo "✗ ts_local - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@localhost:5432/wallet_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ws_local" || echo "✗ ws_local - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@localhost:5432/payment_gateway" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ pg_local" || echo "✗ pg_local - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@localhost:5432/ledger_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ls_local" || echo "✗ ls_local - FAILED"

echo ""
echo "Testing STAGING databases..."
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:4001/transaction_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ts_stage" || echo "✗ ts_stage - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:4002/wallet_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ws_stage" || echo "✗ ws_stage - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:4003/payment_gateway" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ pg_stage" || echo "✗ pg_stage - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:4004/ledger_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ls_stage" || echo "✗ ls_stage - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:6001/profile_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ps_stage" || echo "✗ ps_stage - FAILED"
psql "postgresql://ro_user.uvpghgakjckdoluqnqga:$7Y#zJ@4h!rP6t.@aws-0-us-east-1.pooler.supabase.com:6543/postgres" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ iai_stage (Supabase)" || echo "✗ iai_stage (Supabase) - FAILED"

echo ""
echo "Testing PRODUCTION databases..."
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:5001/transaction_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ts_prod" || echo "✗ ts_prod - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:5002/wallet_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ws_prod" || echo "✗ ws_prod - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:5003/payment_gateway" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ pg_prod" || echo "✗ pg_prod - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:5004/ledger_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ls_prod" || echo "✗ ls_prod - FAILED"
psql "postgresql://ro_user:$7Y#zJ@4h!rP6t.@192.168.100.74:7001/profile_service" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ ps_prod" || echo "✗ ps_prod - FAILED"
psql "postgresql://ro_user.gypnutyegqxelvsqjedu:$7Y#zJ@4h!rP6t.@aws-0-us-east-1.pooler.supabase.com:6543/postgres" -c "SELECT 1;" > /dev/null 2>&1 && echo "✓ iai_prod (Supabase)" || echo "✗ iai_prod (Supabase) - FAILED"

echo ""
echo "=== Test Complete ==="

