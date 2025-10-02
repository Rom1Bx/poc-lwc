#!/bin/bash

# Synchronize a Developer Edition with Git code
# Usage: ./scripts/shell/sync-dev-org.sh dev-feature-a

TARGET_ORG=$1

if [ -z "$TARGET_ORG" ]; then
  echo "❌ Usage: $0 <target-org-alias>"
  exit 1
fi

echo "🔄 Synchronizing with org: ${TARGET_ORG}"

# 1. Verify org exists
sf org display --target-org ${TARGET_ORG} > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "❌ Org ${TARGET_ORG} doesn't exist or isn't authenticated"
  exit 1
fi

# 2. Deploy all local components
echo "📤 Deploying local metadata..."
sf project deploy start \
  --source-dir force-app \
  --target-org ${TARGET_ORG} \
  --ignore-warnings

# 3. Run tests
echo "🧪 Running tests..."
sf apex run test \
  --target-org ${TARGET_ORG} \
  --test-level RunLocalTests \
  --code-coverage \
  --result-format human

echo "✅ Synchronization complete"