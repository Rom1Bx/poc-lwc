#!/bin/bash

FEATURE_NAME=$1
DURATION=${2:-7}  # Default 7 days
ALIAS="scratch-${FEATURE_NAME}"

echo "🚀 Creating Scratch Org: ${ALIAS}"

sf org create scratch \
  --definition-file config/project-scratch-def.json \
  --alias ${ALIAS} \
  --duration-days ${DURATION} \
  --set-default

# Capture exit code
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Command failed with exit code: $?"
    exit 1
fi

echo "✅ Scratch Org created"


echo "📦 Deploying metadata..."
sf project deploy start --source-dir force-app


echo "Assign user permission"
sf org assign permset -n SwaggedAppAccess


echo ""
echo "════════════════════════════════════════════════════"
echo "✅ Scratch Org ready!"
echo "════════════════════════════════════════════════════"
echo "📛 Alias      : ${ALIAS}"
echo "🆔 Org ID     : ${ORG_ID}"
echo "⏰ Expires on : $(date -d "+${DURATION} days" +%Y-%m-%d)"
echo "════════════════════════════════════════════════════"
echo ""
echo "🌐 To open: sf org open --target-org ${ALIAS}"
echo ""

sf org open --target-org ${ALIAS}