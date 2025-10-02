.PHONY: help scratch-create scratch-delete dev-sync dev-open test

# Variables
SCRATCH_CONFIG = config/project-scratch-def.json
DEFAULT_DURATION = 7

help:
	@echo "════════════════════════════════════════════════"
	@echo "  Salesforce Development Automation"
	@echo "════════════════════════════════════════════════"
	@echo ""
	@echo "📦 Scratch Orgs:"
	@echo "  make scratch-create NAME=my-feature [DAYS=7]"
	@echo "  make scratch-delete NAME=my-feature"
	@echo "  make scratch-list"
	@echo ""
	@echo "💻 Developer Orgs:"
	@echo "  make dev-sync ORG=dev-feature-a"
	@echo "  make dev-open ORG=dev-feature-a"
	@echo ""
	@echo "🧪 Tests:"
	@echo "  make test ORG=dev-feature-a"
	@echo ""

# Create a complete Scratch Org
scratch-create:
	@if [ -z "$(NAME)" ]; then echo "❌ Usage: make scratch-create NAME=my-feature"; exit 1; fi
	@./scripts/shell/create-scratch-org.sh $(NAME) $(or $(DAYS),$(DEFAULT_DURATION))

# Delete a Scratch Org
scratch-delete:
	@if [ -z "$(NAME)" ]; then echo "❌ Usage: make scratch-delete NAME=my-feature"; exit 1; fi
	@sf org delete scratch --target-org scratch-$(NAME) --no-prompt
	@echo "✅ Scratch Org scratch-$(NAME) deleted"

# List all orgs
scratch-list:
	@sf org list

# Synchronize a Developer Org
dev-sync:
	@if [ -z "$(ORG)" ]; then echo "❌ Usage: make dev-sync ORG=dev-feature-a"; exit 1; fi
	@./scripts/shell/sync-dev-org.sh $(ORG)

# Open an org
dev-open:
	@if [ -z "$(ORG)" ]; then echo "❌ Usage: make dev-open ORG=dev-feature-a"; exit 1; fi
	@sf org open --target-org $(ORG)

# Run tests
test:
	@if [ -z "$(ORG)" ]; then echo "❌ Usage: make test ORG=dev-feature-a"; exit 1; fi
	@sf apex run test \
		--target-org $(ORG) \
		--test-level RunLocalTests \
		--code-coverage \
		--result-format human