#!/bin/bash
set -e

# 创建扩展
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION pg_trgm;
    CREATE EXTENSION btree_gin;
EOSQL