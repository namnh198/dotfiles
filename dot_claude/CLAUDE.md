# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

## Git: never commit scratch files

- Never add `--force` or `--amend` to git commands. If I want to force-push, I will do it myself. If you think a force push is needed, ask me first.
- Throwaway check scripts, fixtures and probe files go in the session scratchpad, never inside the repo. I do NOT want test scaffolding committed.
- Every commit passes a global gitleaks `pre-commit` hook (`core.hooksPath` = `~/.config/git/hooks`). Never bypass it (`--no-verify`, `-n`, a repo-level `core.hooksPath`) and never edit or remove it.
- When gitleaks blocks a commit: report the `RuleID` and `File` it printed, never the secret itself; move the value out of the file (environment variable, `.env` that is git-ignored) and commit again. If you think it is a false positive, ask me before adding `gitleaks:allow` or a `.gitleaksignore` entry.

## Investigation is read-only

- When investigating, read code, logs and git history, and run `SELECT` queries.
- Ask me before running `UPDATE`, `INSERT` or `DELETE` sql query on any database.
- Never change config, credentials or modules.
- Never touch production.

## Docker execution rule:

Projects run with [lodev](https://github.com/namnh198/lodev): a project is a folder with `.lodev/config.yaml`.
In one, never run these on the host unless the user explicitly overrides this rule; run them in the
project's containers:

- `php`, `composer`, `bin/magento`, `artisan`, `wp`, `n98-magerun2`
- `vendor/bin/phpunit`, `vendor/bin/phpcs`, `vendor/bin/phpstan`
- `npm`, `pnpm`, `yarn`, `node`: the container installs Linux packages, the host's would not match
- `mysql`, `mariadb`, `mysqldump`

### Find the project

- `.lodev/config.yaml`: `name` (the project), `type`, `services`, `working_dir` (default `/app`).
- `lodev describe` (from the project folder) prints its URLs, services, database name and credentials.
- `docker ps` shows whether it runs: web container `lodev-<name>-web`, shared `lodev-mysql`,
  `lodev-mariadb`, `lodev-redis`, `lodev-opensearch`, `lodev-mailpit`. Not running: ask before `lodev start`.

### Commands in the web container (preferred: lodev)

From the project folder (`cd` there first), lodev runs as the project's user in `working_dir`:

```bash
lodev exec php -v                  # any command
lodev composer install             # shortcuts: php composer npm node pnpm yarn grunt artisan wp magento n98
lodev magento cache:flush          # = php bin/magento cache:flush
lodev exec vendor/bin/phpunit
```

Raw `docker exec` only when lodev cannot (e.g. outside the folder). Pass the user and the folder:
the default is root in `/`, which leaves root-owned files in the project.

```bash
docker exec lodev-magento2-web printenv LODEV_USER LODEV_WORKDIR    # e.g. kuroko /app
docker exec -i -u kuroko -w /app lodev-magento2-web php bin/magento -v
```

### Database

- MySQL `lodev-mysql` (client `mysql`) or MariaDB `lodev-mariadb` (client `mariadb`): the project's
  `services` says which. Root password is `root`, also in the container's `$MYSQL_ROOT_PASSWORD` /
  `$MARIADB_ROOT_PASSWORD`.
- Database name: the project name with `-` as `_` (`my-shop` → `my_shop`), sometimes `<name>_staging`;
  the app's config is the truth (`.env`, `app/etc/env.php`, `wp-config.php`). Not sure → ask me.
- Dumps and loads: `lodev db-export` / `lodev db-import -f dump.sql`, and `lodev snapshot create` before
  anything risky.

```bash
docker exec -i lodev-mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;"'
docker exec -i lodev-mariadb sh -c 'exec mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" -e "SHOW DATABASES;"'
```

Investigation stays read-only (above): `SELECT` freely, ask before `UPDATE` / `INSERT` / `DELETE`.

## Tool Selection Guide

| Task                      | Use            | Instead of        |
| ------------------------- | -------------- | ----------------- |
| Search text in code files | `rg` (ripgrep) | `grep`, `grep -r` |
| Find files by name/path   | `fd`           | `find`, `ls -R`   |

### Quick Examples

```bash
rg 'def \w+\(' -t py src/          # rg: text search in Python files
rg -c 'TODO' -t js | wc -l         # rg: count first, then drill down
fd -g '*.test.ts' --changed-within 1d  # fd: -g for compound suffixes (NOT -e)
fd -g '*_test.go' -X rg 'func Test'   # fd+rg: find files, verify contents
```
