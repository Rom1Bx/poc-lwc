#!/bin/bash

# Script to create a ready-to-use Scratch Org
# Usage: ./scripts/shell/create-scratch-org.sh feature-name 7

FEATURE_NAME=$1
DURATION=${2:-7}  # Default 7 days
ALIAS="scratch-${FEATURE_NAME}"

echo "🚀 Creating Scratch Org: ${ALIAS}"

# 1. Create the Scratch Org
sf org create scratch \
  --definition-file config/project-scratch-def.json \
  --alias ${ALIAS} \
  --duration-days ${DURATION} \
  --set-default \
  --json > /tmp/scratch-org.json

# Verify creation
if [ $? -ne 0 ]; then
  echo "❌ Error during creation"
  exit 1
fi

echo "✅ Scratch Org created"

# 2. Deploy metadata
echo "📦 Deploying metadata..."
sf project deploy start --source-dir force-app

# 3. Assign Permission Sets
echo "🔐 Assigning Permission Sets..."
sf org assign permset --name Sales_User
sf org assign permset --name Custom_Features

# 4. Import test data
echo "📊 Importing test data..."
sf data import tree --plan data/accounts-contacts-plan.json

# 5. Execute setup Apex script
echo "⚙️  Executing setup script..."
sf apex run --file scripts/apex/post-scratch-setup.apex

# 6. Generate password
echo "🔑 Generating password..."
PASSWORD=$(sf org generate password --json | jq -r '.result.password')

# 7. Get connection info
ORG_ID=$(cat /tmp/scratch-org.json | jq -r '.result.orgId')
USERNAME=$(cat /tmp/scratch-org.json | jq -r '.result.username')

# 8. Display summary
echo ""
echo "════════════════════════════════════════════════════"
echo "✅ Scratch Org ready!"
echo "════════════════════════════════════════════════════"
echo "📛 Alias      : ${ALIAS}"
echo "🆔 Org ID     : ${ORG_ID}"
echo "👤 Username   : ${USERNAME}"
echo "🔑 Password   : ${PASSWORD}"
echo "⏰ Expires on : $(date -d "+${DURATION} days" +%Y-%m-%d)"
echo "════════════════════════════════════════════════════"
echo ""
echo "🌐 To open: sf org open --target-org ${ALIAS}"
echo ""

# 9. Open automatically
sf org open --target-org ${ALIAS}