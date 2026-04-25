# Reference Consolidation

Generated at: `2026-04-25T06:29:16+00:00`

## Process

1. Run `python3 scripts/reference_inventory.py --json-out catalog/reference-inventory.json --markdown-out docs/reference-consolidation.md`.
2. Review the raw inventory grouped by source before making taxonomy decisions.
3. Keep every external item in one of four buckets: `process-skill`, `domain-skill`, `agent-role`, or `reference-only`.
4. Merge duplicates by behavior, not by name. Preserve only the strongest instruction set for each adopted capability.
5. Record explicit reject reasons for entries that remain reference-only so the toolkit does not silently drift back toward provider-specific sprawl.

## Unified taxonomy

- `process-skill`: reusable workflow skills for planning, verification, review, debugging, and delegation
- `domain-skill`: topic-specific skills that remain useful after provider-specific wording is removed
- `agent-role`: multi-agent roles or specialist personas that Codex can run via `config_file`-backed agent configs
- `reference-only`: useful inspiration that should not be installed directly into this toolkit

## Source summary

| Source | Commit | Entries |
| --- | --- | ---: |
| workflows | `d74933c8311a` | 115 |
| awesome-claude-code-subagents | `6f804f0cfab2` | 144 |

## Inventory

| Source | Kind | Name | Suggested bucket | Path |
| --- | --- | --- | --- | --- |
| awesome-claude-code-subagents | agent | `accessibility-tester` | agent-role | `categories/04-quality-security/accessibility-tester.md` |
| awesome-claude-code-subagents | agent | `ad-security-reviewer` | agent-role | `categories/04-quality-security/ad-security-reviewer.md` |
| awesome-claude-code-subagents | agent | `agent-installer` | agent-role | `categories/09-meta-orchestration/agent-installer.md` |
| awesome-claude-code-subagents | agent | `agent-organizer` | agent-role | `categories/09-meta-orchestration/agent-organizer.md` |
| awesome-claude-code-subagents | agent | `ai-engineer` | agent-role | `categories/05-data-ai/ai-engineer.md` |
| awesome-claude-code-subagents | agent | `ai-writing-auditor` | agent-role | `categories/04-quality-security/ai-writing-auditor.md` |
| awesome-claude-code-subagents | agent | `angular-architect` | agent-role | `categories/02-language-specialists/angular-architect.md` |
| awesome-claude-code-subagents | agent | `api-designer` | agent-role | `categories/01-core-development/api-designer.md` |
| awesome-claude-code-subagents | agent | `api-documenter` | agent-role | `categories/07-specialized-domains/api-documenter.md` |
| awesome-claude-code-subagents | agent | `architect-reviewer` | agent-role | `categories/04-quality-security/architect-reviewer.md` |
| awesome-claude-code-subagents | agent | `azure-infra-engineer` | agent-role | `categories/03-infrastructure/azure-infra-engineer.md` |
| awesome-claude-code-subagents | agent | `backend-developer` | agent-role | `categories/01-core-development/backend-developer.md` |
| awesome-claude-code-subagents | agent | `blockchain-developer` | agent-role | `categories/07-specialized-domains/blockchain-developer.md` |
| awesome-claude-code-subagents | agent | `build-engineer` | agent-role | `categories/06-developer-experience/build-engineer.md` |
| awesome-claude-code-subagents | agent | `business-analyst` | agent-role | `categories/08-business-product/business-analyst.md` |
| awesome-claude-code-subagents | agent | `chaos-engineer` | agent-role | `categories/04-quality-security/chaos-engineer.md` |
| awesome-claude-code-subagents | agent | `cli-developer` | agent-role | `categories/06-developer-experience/cli-developer.md` |
| awesome-claude-code-subagents | agent | `cloud-architect` | agent-role | `categories/03-infrastructure/cloud-architect.md` |
| awesome-claude-code-subagents | agent | `code-reviewer` | agent-role | `categories/04-quality-security/code-reviewer.md` |
| awesome-claude-code-subagents | agent | `codebase-orchestrator` | agent-role | `categories/09-meta-orchestration/codebase-orchestrator.md` |
| awesome-claude-code-subagents | agent | `competitive-analyst` | agent-role | `categories/10-research-analysis/competitive-analyst.md` |
| awesome-claude-code-subagents | agent | `compliance-auditor` | agent-role | `categories/04-quality-security/compliance-auditor.md` |
| awesome-claude-code-subagents | agent | `content-marketer` | agent-role | `categories/08-business-product/content-marketer.md` |
| awesome-claude-code-subagents | agent | `context-manager` | agent-role | `categories/09-meta-orchestration/context-manager.md` |
| awesome-claude-code-subagents | agent | `cpp-pro` | agent-role | `categories/02-language-specialists/cpp-pro.md` |
| awesome-claude-code-subagents | agent | `csharp-developer` | agent-role | `categories/02-language-specialists/csharp-developer.md` |
| awesome-claude-code-subagents | agent | `customer-success-manager` | agent-role | `categories/08-business-product/customer-success-manager.md` |
| awesome-claude-code-subagents | agent | `data-analyst` | agent-role | `categories/05-data-ai/data-analyst.md` |
| awesome-claude-code-subagents | agent | `data-engineer` | agent-role | `categories/05-data-ai/data-engineer.md` |
| awesome-claude-code-subagents | agent | `data-researcher` | agent-role | `categories/10-research-analysis/data-researcher.md` |
| awesome-claude-code-subagents | agent | `data-scientist` | agent-role | `categories/05-data-ai/data-scientist.md` |
| awesome-claude-code-subagents | agent | `database-administrator` | agent-role | `categories/03-infrastructure/database-administrator.md` |
| awesome-claude-code-subagents | agent | `database-optimizer` | agent-role | `categories/05-data-ai/database-optimizer.md` |
| awesome-claude-code-subagents | agent | `debugger` | agent-role | `categories/04-quality-security/debugger.md` |
| awesome-claude-code-subagents | agent | `dependency-manager` | agent-role | `categories/06-developer-experience/dependency-manager.md` |
| awesome-claude-code-subagents | agent | `deployment-engineer` | agent-role | `categories/03-infrastructure/deployment-engineer.md` |
| awesome-claude-code-subagents | agent | `design-bridge` | agent-role | `categories/01-core-development/design-bridge.md` |
| awesome-claude-code-subagents | agent | `devops-engineer` | agent-role | `categories/03-infrastructure/devops-engineer.md` |
| awesome-claude-code-subagents | agent | `devops-incident-responder` | agent-role | `categories/03-infrastructure/devops-incident-responder.md` |
| awesome-claude-code-subagents | agent | `django-developer` | agent-role | `categories/02-language-specialists/django-developer.md` |
| awesome-claude-code-subagents | agent | `docker-expert` | agent-role | `categories/03-infrastructure/docker-expert.md` |
| awesome-claude-code-subagents | agent | `documentation-engineer` | agent-role | `categories/06-developer-experience/documentation-engineer.md` |
| awesome-claude-code-subagents | agent | `dotnet-core-expert` | agent-role | `categories/02-language-specialists/dotnet-core-expert.md` |
| awesome-claude-code-subagents | agent | `dotnet-framework-4.8-expert` | agent-role | `categories/02-language-specialists/dotnet-framework-4.8-expert.md` |
| awesome-claude-code-subagents | agent | `dx-optimizer` | agent-role | `categories/06-developer-experience/dx-optimizer.md` |
| awesome-claude-code-subagents | agent | `electron-pro` | agent-role | `categories/01-core-development/electron-pro.md` |
| awesome-claude-code-subagents | agent | `elixir-expert` | agent-role | `categories/02-language-specialists/elixir-expert.md` |
| awesome-claude-code-subagents | agent | `embedded-systems` | agent-role | `categories/07-specialized-domains/embedded-systems.md` |
| awesome-claude-code-subagents | agent | `error-coordinator` | agent-role | `categories/09-meta-orchestration/error-coordinator.md` |
| awesome-claude-code-subagents | agent | `error-detective` | agent-role | `categories/04-quality-security/error-detective.md` |
| awesome-claude-code-subagents | agent | `expo-react-native-expert` | agent-role | `categories/02-language-specialists/expo-react-native-expert.md` |
| awesome-claude-code-subagents | agent | `fastapi-developer` | agent-role | `categories/02-language-specialists/fastapi-developer.md` |
| awesome-claude-code-subagents | agent | `fintech-engineer` | agent-role | `categories/07-specialized-domains/fintech-engineer.md` |
| awesome-claude-code-subagents | agent | `flutter-expert` | agent-role | `categories/02-language-specialists/flutter-expert.md` |
| awesome-claude-code-subagents | agent | `frontend-developer` | agent-role | `categories/01-core-development/frontend-developer.md` |
| awesome-claude-code-subagents | agent | `fullstack-developer` | agent-role | `categories/01-core-development/fullstack-developer.md` |
| awesome-claude-code-subagents | agent | `game-developer` | agent-role | `categories/07-specialized-domains/game-developer.md` |
| awesome-claude-code-subagents | agent | `git-workflow-manager` | agent-role | `categories/06-developer-experience/git-workflow-manager.md` |
| awesome-claude-code-subagents | agent | `golang-pro` | agent-role | `categories/02-language-specialists/golang-pro.md` |
| awesome-claude-code-subagents | agent | `graphql-architect` | agent-role | `categories/01-core-development/graphql-architect.md` |
| awesome-claude-code-subagents | agent | `healthcare-admin` | agent-role | `categories/07-specialized-domains/healthcare-admin.md` |
| awesome-claude-code-subagents | agent | `incident-responder` | agent-role | `categories/03-infrastructure/incident-responder.md` |
| awesome-claude-code-subagents | agent | `iot-engineer` | agent-role | `categories/07-specialized-domains/iot-engineer.md` |
| awesome-claude-code-subagents | agent | `it-ops-orchestrator` | agent-role | `categories/09-meta-orchestration/it-ops-orchestrator.md` |
| awesome-claude-code-subagents | agent | `java-architect` | agent-role | `categories/02-language-specialists/java-architect.md` |
| awesome-claude-code-subagents | agent | `javascript-pro` | agent-role | `categories/02-language-specialists/javascript-pro.md` |
| awesome-claude-code-subagents | agent | `knowledge-synthesizer` | agent-role | `categories/09-meta-orchestration/knowledge-synthesizer.md` |
| awesome-claude-code-subagents | agent | `kotlin-specialist` | agent-role | `categories/02-language-specialists/kotlin-specialist.md` |
| awesome-claude-code-subagents | agent | `kubernetes-specialist` | agent-role | `categories/03-infrastructure/kubernetes-specialist.md` |
| awesome-claude-code-subagents | agent | `laravel-specialist` | agent-role | `categories/02-language-specialists/laravel-specialist.md` |
| awesome-claude-code-subagents | agent | `legacy-modernizer` | agent-role | `categories/06-developer-experience/legacy-modernizer.md` |
| awesome-claude-code-subagents | agent | `legal-advisor` | agent-role | `categories/08-business-product/legal-advisor.md` |
| awesome-claude-code-subagents | agent | `license-engineer` | agent-role | `categories/08-business-product/license-engineer.md` |
| awesome-claude-code-subagents | agent | `llm-architect` | agent-role | `categories/05-data-ai/llm-architect.md` |
| awesome-claude-code-subagents | agent | `m365-admin` | agent-role | `categories/07-specialized-domains/m365-admin.md` |
| awesome-claude-code-subagents | agent | `machine-learning-engineer` | agent-role | `categories/05-data-ai/machine-learning-engineer.md` |
| awesome-claude-code-subagents | agent | `market-researcher` | agent-role | `categories/10-research-analysis/market-researcher.md` |
| awesome-claude-code-subagents | agent | `mcp-developer` | agent-role | `categories/06-developer-experience/mcp-developer.md` |
| awesome-claude-code-subagents | agent | `microservices-architect` | agent-role | `categories/01-core-development/microservices-architect.md` |
| awesome-claude-code-subagents | agent | `ml-engineer` | agent-role | `categories/05-data-ai/ml-engineer.md` |
| awesome-claude-code-subagents | agent | `mlops-engineer` | agent-role | `categories/05-data-ai/mlops-engineer.md` |
| awesome-claude-code-subagents | agent | `mobile-app-developer` | agent-role | `categories/07-specialized-domains/mobile-app-developer.md` |
| awesome-claude-code-subagents | agent | `mobile-developer` | agent-role | `categories/01-core-development/mobile-developer.md` |
| awesome-claude-code-subagents | agent | `multi-agent-coordinator` | agent-role | `categories/09-meta-orchestration/multi-agent-coordinator.md` |
| awesome-claude-code-subagents | agent | `network-engineer` | agent-role | `categories/03-infrastructure/network-engineer.md` |
| awesome-claude-code-subagents | agent | `nextjs-developer` | agent-role | `categories/02-language-specialists/nextjs-developer.md` |
| awesome-claude-code-subagents | agent | `nlp-engineer` | agent-role | `categories/05-data-ai/nlp-engineer.md` |
| awesome-claude-code-subagents | agent | `node-specialist` | agent-role | `categories/02-language-specialists/node-specialist.md` |
| awesome-claude-code-subagents | agent | `payment-integration` | agent-role | `categories/07-specialized-domains/payment-integration.md` |
| awesome-claude-code-subagents | agent | `penetration-tester` | agent-role | `categories/04-quality-security/penetration-tester.md` |
| awesome-claude-code-subagents | agent | `performance-engineer` | agent-role | `categories/04-quality-security/performance-engineer.md` |
| awesome-claude-code-subagents | agent | `performance-monitor` | agent-role | `categories/09-meta-orchestration/performance-monitor.md` |
| awesome-claude-code-subagents | agent | `php-pro` | agent-role | `categories/02-language-specialists/php-pro.md` |
| awesome-claude-code-subagents | agent | `platform-engineer` | agent-role | `categories/03-infrastructure/platform-engineer.md` |
| awesome-claude-code-subagents | agent | `postgres-pro` | agent-role | `categories/05-data-ai/postgres-pro.md` |
| awesome-claude-code-subagents | agent | `powershell-5.1-expert` | agent-role | `categories/02-language-specialists/powershell-5.1-expert.md` |
| awesome-claude-code-subagents | agent | `powershell-7-expert` | agent-role | `categories/02-language-specialists/powershell-7-expert.md` |
| awesome-claude-code-subagents | agent | `powershell-module-architect` | agent-role | `categories/06-developer-experience/powershell-module-architect.md` |
| awesome-claude-code-subagents | agent | `powershell-security-hardening` | agent-role | `categories/04-quality-security/powershell-security-hardening.md` |
| awesome-claude-code-subagents | agent | `powershell-ui-architect` | agent-role | `categories/06-developer-experience/powershell-ui-architect.md` |
| awesome-claude-code-subagents | agent | `product-manager` | agent-role | `categories/08-business-product/product-manager.md` |
| awesome-claude-code-subagents | agent | `project-idea-validator` | agent-role | `categories/10-research-analysis/project-idea-validator.md` |
| awesome-claude-code-subagents | agent | `project-manager` | agent-role | `categories/08-business-product/project-manager.md` |
| awesome-claude-code-subagents | agent | `prompt-engineer` | agent-role | `categories/05-data-ai/prompt-engineer.md` |
| awesome-claude-code-subagents | agent | `python-pro` | agent-role | `categories/02-language-specialists/python-pro.md` |
| awesome-claude-code-subagents | agent | `qa-expert` | agent-role | `categories/04-quality-security/qa-expert.md` |
| awesome-claude-code-subagents | agent | `quant-analyst` | agent-role | `categories/07-specialized-domains/quant-analyst.md` |
| awesome-claude-code-subagents | agent | `rails-expert` | agent-role | `categories/02-language-specialists/rails-expert.md` |
| awesome-claude-code-subagents | agent | `react-specialist` | agent-role | `categories/02-language-specialists/react-specialist.md` |
| awesome-claude-code-subagents | agent | `readme-generator` | agent-role | `categories/06-developer-experience/readme-generator.md` |
| awesome-claude-code-subagents | agent | `refactoring-specialist` | agent-role | `categories/06-developer-experience/refactoring-specialist.md` |
| awesome-claude-code-subagents | agent | `reinforcement-learning-engineer` | agent-role | `categories/05-data-ai/reinforcement-learning-engineer.md` |
| awesome-claude-code-subagents | agent | `research-analyst` | agent-role | `categories/10-research-analysis/research-analyst.md` |
| awesome-claude-code-subagents | agent | `risk-manager` | agent-role | `categories/07-specialized-domains/risk-manager.md` |
| awesome-claude-code-subagents | agent | `rust-engineer` | agent-role | `categories/02-language-specialists/rust-engineer.md` |
| awesome-claude-code-subagents | agent | `sales-engineer` | agent-role | `categories/08-business-product/sales-engineer.md` |
| awesome-claude-code-subagents | agent | `scientific-literature-researcher` | agent-role | `categories/10-research-analysis/scientific-literature-researcher.md` |
| awesome-claude-code-subagents | agent | `scrum-master` | agent-role | `categories/08-business-product/scrum-master.md` |
| awesome-claude-code-subagents | agent | `search-specialist` | agent-role | `categories/10-research-analysis/search-specialist.md` |
| awesome-claude-code-subagents | agent | `security-auditor` | agent-role | `categories/04-quality-security/security-auditor.md` |
| awesome-claude-code-subagents | agent | `security-engineer` | agent-role | `categories/03-infrastructure/security-engineer.md` |
| awesome-claude-code-subagents | agent | `seo-specialist` | agent-role | `categories/07-specialized-domains/seo-specialist.md` |
| awesome-claude-code-subagents | agent | `slack-expert` | agent-role | `categories/06-developer-experience/slack-expert.md` |
| awesome-claude-code-subagents | agent | `spring-boot-engineer` | agent-role | `categories/02-language-specialists/spring-boot-engineer.md` |
| awesome-claude-code-subagents | agent | `sql-pro` | agent-role | `categories/02-language-specialists/sql-pro.md` |
| awesome-claude-code-subagents | agent | `sre-engineer` | agent-role | `categories/03-infrastructure/sre-engineer.md` |
| awesome-claude-code-subagents | agent | `swift-expert` | agent-role | `categories/02-language-specialists/swift-expert.md` |
| awesome-claude-code-subagents | agent | `symfony-specialist` | agent-role | `categories/02-language-specialists/symfony-specialist.md` |
| awesome-claude-code-subagents | agent | `task-distributor` | agent-role | `categories/09-meta-orchestration/task-distributor.md` |
| awesome-claude-code-subagents | agent | `technical-writer` | agent-role | `categories/08-business-product/technical-writer.md` |
| awesome-claude-code-subagents | agent | `terraform-engineer` | agent-role | `categories/03-infrastructure/terraform-engineer.md` |
| awesome-claude-code-subagents | agent | `terragrunt-expert` | agent-role | `categories/03-infrastructure/terragrunt-expert.md` |
| awesome-claude-code-subagents | agent | `test-automator` | agent-role | `categories/04-quality-security/test-automator.md` |
| awesome-claude-code-subagents | agent | `tooling-engineer` | agent-role | `categories/06-developer-experience/tooling-engineer.md` |
| awesome-claude-code-subagents | agent | `trend-analyst` | agent-role | `categories/10-research-analysis/trend-analyst.md` |
| awesome-claude-code-subagents | agent | `typescript-pro` | agent-role | `categories/02-language-specialists/typescript-pro.md` |
| awesome-claude-code-subagents | agent | `ui-designer` | agent-role | `categories/01-core-development/ui-designer.md` |
| awesome-claude-code-subagents | agent | `ui-ux-tester` | agent-role | `categories/04-quality-security/ui-ux-tester.md` |
| awesome-claude-code-subagents | agent | `ux-researcher` | agent-role | `categories/08-business-product/ux-researcher.md` |
| awesome-claude-code-subagents | agent | `vue-expert` | agent-role | `categories/02-language-specialists/vue-expert.md` |
| awesome-claude-code-subagents | agent | `websocket-engineer` | agent-role | `categories/01-core-development/websocket-engineer.md` |
| awesome-claude-code-subagents | agent | `windows-infra-admin` | agent-role | `categories/03-infrastructure/windows-infra-admin.md` |
| awesome-claude-code-subagents | agent | `wordpress-master` | agent-role | `categories/08-business-product/wordpress-master.md` |
| awesome-claude-code-subagents | agent | `workflow-orchestrator` | agent-role | `categories/09-meta-orchestration/workflow-orchestrator.md` |
| workflows | agent | `architect` | agent-role | `agents/architect.md` |
| workflows | agent | `assistant` | agent-role | `agents/assistant.md` |
| workflows | agent | `build-error-resolver` | agent-role | `agents/build-error-resolver.md` |
| workflows | agent | `code-reviewer` | agent-role | `agents/code-reviewer.md` |
| workflows | agent | `data-explorer` | agent-role | `agents/data-explorer.md` |
| workflows | agent | `dev-debugger` | agent-role | `agents/dev-debugger.md` |
| workflows | agent | `dev-implementer` | agent-role | `agents/dev-implementer.md` |
| workflows | agent | `dev-plan-checker` | agent-role | `agents/dev-plan-checker.md` |
| workflows | agent | `dev-verifier` | agent-role | `agents/dev-verifier.md` |
| workflows | agent | `doc-updater` | agent-role | `agents/doc-updater.md` |
| workflows | agent | `ds-analyst` | agent-role | `agents/ds-analyst.md` |
| workflows | agent | `ds-engineer` | agent-role | `agents/ds-engineer.md` |
| workflows | agent | `e2e-runner` | agent-role | `agents/e2e-runner.md` |
| workflows | agent | `librarian` | agent-role | `agents/librarian.md` |
| workflows | agent | `planner` | agent-role | `agents/planner.md` |
| workflows | agent | `refactor-cleaner` | agent-role | `agents/refactor-cleaner.md` |
| workflows | agent | `security-reviewer` | agent-role | `agents/security-reviewer.md` |
| workflows | agent | `tdd-guide` | agent-role | `agents/tdd-guide.md` |
| workflows | agent | `test-gap-auditor` | agent-role | `agents/test-gap-auditor.md` |
| workflows | agent | `writing-prose-reviewer` | agent-role | `agents/writing-prose-reviewer.md` |
| workflows | agent | `writing-source-fidelity-reviewer` | agent-role | `agents/writing-source-fidelity-reviewer.md` |
| workflows | skill | `ai-anti-patterns` | domain-skill | `skills/ai-anti-patterns/SKILL.md` |
| workflows | skill | `audit-archive` | domain-skill | `skills/bluebook-audit/skills/audit-archive/SKILL.md` |
| workflows | skill | `audit-check` | domain-skill | `skills/bluebook-audit/skills/audit-check/SKILL.md` |
| workflows | skill | `audit-correct` | domain-skill | `skills/bluebook-audit/skills/audit-correct/SKILL.md` |
| workflows | skill | `audit-crossrefs` | domain-skill | `skills/bluebook-audit/skills/audit-crossrefs/SKILL.md` |
| workflows | skill | `audit-extract` | domain-skill | `skills/bluebook-audit/skills/audit-extract/SKILL.md` |
| workflows | skill | `audit-fix-loop` | domain-skill | `skills/audit-fix-loop/SKILL.md` |
| workflows | skill | `audit-report` | domain-skill | `skills/bluebook-audit/skills/audit-report/SKILL.md` |
| workflows | skill | `audit-verify` | process-skill | `skills/bluebook-audit/skills/audit-verify/SKILL.md` |
| workflows | skill | `bluebook` | domain-skill | `skills/bluebook/SKILL.md` |
| workflows | skill | `bluebook-audit` | domain-skill | `skills/bluebook-audit/SKILL.md` |
| workflows | skill | `consensus` | domain-skill | `skills/consensus/SKILL.md` |
| workflows | skill | `continuous-learning` | domain-skill | `skills/continuous-learning/SKILL.md` |
| workflows | skill | `data-context` | domain-skill | `skills/data-context/SKILL.md` |
| workflows | skill | `dev` | domain-skill | `skills/dev/SKILL.md` |
| workflows | skill | `dev-clarify` | domain-skill | `skills/dev-clarify/SKILL.md` |
| workflows | skill | `dev-debug` | process-skill | `skills/dev-debug/SKILL.md` |
| workflows | skill | `dev-delegate` | process-skill | `skills/dev-delegate/SKILL.md` |
| workflows | skill | `dev-design` | domain-skill | `skills/dev-design/SKILL.md` |
| workflows | skill | `dev-explore` | domain-skill | `skills/dev-explore/SKILL.md` |
| workflows | skill | `dev-handoff` | domain-skill | `skills/dev-handoff/SKILL.md` |
| workflows | skill | `dev-implement` | domain-skill | `skills/dev-implement/SKILL.md` |
| workflows | skill | `dev-plan-reviewer` | process-skill | `skills/dev-plan-reviewer/SKILL.md` |
| workflows | skill | `dev-ralph-loop` | domain-skill | `skills/dev-ralph-loop/SKILL.md` |
| workflows | skill | `dev-review` | process-skill | `skills/dev-review/SKILL.md` |
| workflows | skill | `dev-spec-reviewer` | process-skill | `skills/dev-spec-reviewer/SKILL.md` |
| workflows | skill | `dev-tdd` | domain-skill | `skills/dev-tdd/SKILL.md` |
| workflows | skill | `dev-test` | process-skill | `skills/dev-test/SKILL.md` |
| workflows | skill | `dev-test-chrome` | process-skill | `skills/dev-test-chrome/SKILL.md` |
| workflows | skill | `dev-test-electron` | process-skill | `skills/dev-test-electron/SKILL.md` |
| workflows | skill | `dev-test-gaps` | process-skill | `skills/dev-test-gaps/SKILL.md` |
| workflows | skill | `dev-test-hammerspoon` | process-skill | `skills/dev-test-hammerspoon/SKILL.md` |
| workflows | skill | `dev-test-linux` | process-skill | `skills/dev-test-linux/SKILL.md` |
| workflows | skill | `dev-test-playwright` | process-skill | `skills/dev-test-playwright/SKILL.md` |
| workflows | skill | `dev-tools` | domain-skill | `skills/dev-tools/SKILL.md` |
| workflows | skill | `dev-verify` | process-skill | `skills/dev-verify/SKILL.md` |
| workflows | skill | `dev-worktree` | process-skill | `skills/dev-worktree/SKILL.md` |
| workflows | skill | `docx-footnotes` | domain-skill | `skills/docx-footnotes/SKILL.md` |
| workflows | skill | `ds` | domain-skill | `skills/ds/SKILL.md` |
| workflows | skill | `ds-delegate` | process-skill | `skills/ds-delegate/SKILL.md` |
| workflows | skill | `ds-fix` | domain-skill | `skills/ds-fix/SKILL.md` |
| workflows | skill | `ds-handoff` | domain-skill | `skills/ds-handoff/SKILL.md` |
| workflows | skill | `ds-implement` | domain-skill | `skills/ds-implement/SKILL.md` |
| workflows | skill | `ds-plan` | process-skill | `skills/ds-plan/SKILL.md` |
| workflows | skill | `ds-plan-reviewer` | process-skill | `skills/ds-plan-reviewer/SKILL.md` |
| workflows | skill | `ds-review` | process-skill | `skills/ds-review/SKILL.md` |
| workflows | skill | `ds-spec-reviewer` | process-skill | `skills/ds-spec-reviewer/SKILL.md` |
| workflows | skill | `ds-tools` | domain-skill | `skills/ds-tools/SKILL.md` |
| workflows | skill | `ds-validate` | domain-skill | `skills/ds-validate/SKILL.md` |
| workflows | skill | `ds-verify` | process-skill | `skills/ds-verify/SKILL.md` |
| workflows | skill | `gemini-batch` | domain-skill | `skills/gemini-batch/SKILL.md` |
| workflows | skill | `google-scholar` | domain-skill | `skills/google-scholar/SKILL.md` |
| workflows | skill | `headline-card` | domain-skill | `skills/headline-card/SKILL.md` |
| workflows | skill | `jupytext` | domain-skill | `skills/jupytext/SKILL.md` |
| workflows | skill | `law-review-docx` | process-skill | `skills/law-review-docx/SKILL.md` |
| workflows | skill | `look-at` | domain-skill | `skills/look-at/SKILL.md` |
| workflows | skill | `lseg-data` | domain-skill | `skills/lseg-data/SKILL.md` |
| workflows | skill | `marimo` | domain-skill | `skills/marimo/SKILL.md` |
| workflows | skill | `marimo-serve` | domain-skill | `skills/marimo/marimo-serve/SKILL.md` |
| workflows | skill | `nlm` | domain-skill | `skills/nlm/SKILL.md` |
| workflows | skill | `notebook-debug` | process-skill | `skills/notebook-debug/SKILL.md` |
| workflows | skill | `obsidian-organize` | domain-skill | `skills/obsidian-organize/SKILL.md` |
| workflows | skill | `pattern-capture` | domain-skill | `skills/pattern-capture/SKILL.md` |
| workflows | skill | `plugin-creator` | domain-skill | `skills/plugin-creator/SKILL.md` |
| workflows | skill | `pptx-render` | domain-skill | `skills/pptx-render/SKILL.md` |
| workflows | skill | `readwise` | domain-skill | `skills/readwise/SKILL.md` |
| workflows | skill | `readwise-chat` | domain-skill | `skills/readwise-chat/SKILL.md` |
| workflows | skill | `readwise-docs` | domain-skill | `skills/readwise-docs/SKILL.md` |
| workflows | skill | `readwise-prune` | domain-skill | `skills/readwise-prune/SKILL.md` |
| workflows | skill | `readwise-search` | domain-skill | `skills/readwise-search/SKILL.md` |
| workflows | skill | `research` | domain-skill | `skills/research/SKILL.md` |
| workflows | skill | `skill-creator` | domain-skill | `skills/skill-creator/SKILL.md` |
| workflows | skill | `source-verify` | process-skill | `skills/source-verify/SKILL.md` |
| workflows | skill | `typst-test-slide` | process-skill | `skills/tinymist/typst-test-slide/SKILL.md` |
| workflows | skill | `using-skills` | process-skill | `skills/using-skills/SKILL.md` |
| workflows | skill | `visual-mockup` | domain-skill | `skills/visual-mockup/SKILL.md` |
| workflows | skill | `visual-verify` | process-skill | `skills/visual-verify/SKILL.md` |
| workflows | skill | `workflow-creator` | domain-skill | `skills/workflow-creator/SKILL.md` |
| workflows | skill | `workshop` | domain-skill | `skills/workshop/SKILL.md` |
| workflows | skill | `workshop-revise` | domain-skill | `skills/workshop-revise/SKILL.md` |
| workflows | skill | `wrds` | domain-skill | `skills/wrds/SKILL.md` |
| workflows | skill | `writing` | domain-skill | `skills/writing/SKILL.md` |
| workflows | skill | `writing-draft` | domain-skill | `skills/writing-draft/SKILL.md` |
| workflows | skill | `writing-econ` | domain-skill | `skills/writing-econ/SKILL.md` |
| workflows | skill | `writing-general` | domain-skill | `skills/writing-general/SKILL.md` |
| workflows | skill | `writing-handoff` | domain-skill | `skills/writing-handoff/SKILL.md` |
| workflows | skill | `writing-legal` | domain-skill | `skills/writing-legal/SKILL.md` |
| workflows | skill | `writing-outline` | domain-skill | `skills/writing-outline/SKILL.md` |
| workflows | skill | `writing-outline-reviewer` | process-skill | `skills/writing-outline-reviewer/SKILL.md` |
| workflows | skill | `writing-precis-reviewer` | process-skill | `skills/writing-precis-reviewer/SKILL.md` |
| workflows | skill | `writing-review` | process-skill | `skills/writing-review/SKILL.md` |
| workflows | skill | `writing-revise` | domain-skill | `skills/writing-revise/SKILL.md` |
| workflows | skill | `writing-setup` | domain-skill | `skills/writing-setup/SKILL.md` |
| workflows | skill | `writing-validate` | domain-skill | `skills/writing-validate/SKILL.md` |

## Codex constraints

- Codex reads repo and user skills from `.agents/skills` locations and follows symlinked skill folders.
- Project-level agent roles should be declared in `.codex/config.toml` using `[agents.<name>]` plus `config_file` references.
- Multi-agent setups should keep agent roles small and specialized, with read-only roles for research and review when possible.
