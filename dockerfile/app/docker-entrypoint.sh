#!/bin/bash
set -e

composer init-db

exec "$@"