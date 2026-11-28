# CLAUDE.md

Bias toward caution over speed; use judgment on trivial tasks.

## Before and while coding

- State assumptions. If a request is unclear or has several readings, name what's unclear and ask, or list the options; never pick silently. Suggest a simpler approach and push back when warranted.
- Keep diffs surgical: every changed line traces to the request. Match the existing style; don't reformat, refactor or "improve" code outside the task. Remove only what your own change made unused; mention other dead code instead of deleting it.
- Turn tasks into verifiable goals (validation → tests for invalid input, then pass; bug → failing repro test, then pass; refactor → tests pass before and after). For multi-step work, give a short plan as `step → verify: check` and loop until each check passes.

## Git

- Never use `--force` or `--amend`. If a force push seems needed, ask me; I run it myself.
- Throwaway scripts, fixtures and probe files go in the session scratchpad, never in the repo.
- Every commit runs a global gitleaks pre-commit hook (`core.hooksPath=~/.config/git/hooks`). Never bypass it (`--no-verify`, `-n`, a repo-level `core.hooksPath`), edit it or remove it.
- If gitleaks blocks a commit: report its `RuleID` and `File`, never the secret; move the value to an env var or a git-ignored `.env`; commit again. Suspected false positive → ask before adding `gitleaks:allow` or a `.gitleaksignore` entry.
- Never add a `Co-Authored-By` trailer or `<noreply@anthropic.com>` to git commit messages.
- Commit message: short and meaningful, one subject line saying what changed and why; add a body only when the subject cannot carry it.

## Language

Talk to me in Vietnamese. Everything written to disk or to Jira is English: `docs`, `specs`, `plans`, `tickets`, `adr`, `commits`, `PR text`, `branch names`.

## Personal docs (never committed)

- My specs, plans, tickets, ADRs, CONTEXT.md and research notes live only in `.agent-docs/` at the repo root (`specs/`, `plans/`, `tickets/`, `adr/`, `drafts/`), even when a skill's default path differs. It is git-ignored globally; never `git add` it.
- Never put these conventions in tracked files (`README`, `CLAUDE.md`, `AGENTS.md`, `docs/`); if a repo needs local config, use `CLAUDE.local.md`.

## Jira and tickets

For Jira issues, always ask me preview with formatted text (NOT raw code) and a 3-5 line Vietnamese summary, and wait for my approval before creating, editing, commenting on or transitioning a Jira issue.

Jira searches use `maxResults: 10`.

## Investigation is read-only

- Read code, logs and git history; run `SELECT` freely.
- Ask before any `UPDATE`/`INSERT`/`DELETE` on any database.
- Never change config, credentials or modules. Never touch production.

## Remote servers (staging, production)

Never connect to them (`ssh`, `scp`, `sftp`), not even read-only; I run those checks myself. When one is needed, give me the exact commands, using `grep`/`find`/`tail`/`awk` (no `rg`/`fd` there), and wait for my output; Make sure never has the keys, tokens, sftp informations on those.

## lodev projects (folder contains `.lodev/config.yaml`)

Unless I explicitly override this, never run these on the host; run them in the project's containers: `php`, `composer`, `bin/magento`, `artisan`, `wp`, `n98-magerun2`, `vendor/bin/{phpunit,phpcs,phpstan}`, `npm`/`pnpm`/`yarn`/`node` (host packages won't match the Linux container), `mysql`/`mariadb`/`mysqldump`.

- Project info: `.lodev/config.yaml` (`name`, `type`, `services`, `working_dir`, default `/app`); `lodev describe` prints URLs, services, DB name and credentials.
- Running? `docker ps`: web `lodev-<name>-web`; shared `lodev-{mysql,mariadb,redis,opensearch,mailpit}`. Not running → ask before `lodev start`.
- Preferred, from the project folder: `lodev exec <cmd>` or shortcuts `lodev <php|composer|npm|node|pnpm|yarn|grunt|artisan|wp|magento|n98> …` (`lodev magento x` = `php bin/magento x`). They run as the project user in `working_dir`.
- Raw `docker exec` only when lodev can't. Its default is root in `/` (leaves root-owned files), so pass both: get them with `docker exec lodev-<name>-web printenv LODEV_USER LODEV_WORKDIR`, then `docker exec -i -u <user> -w <workdir> lodev-<name>-web <cmd>`.
- Database: MySQL (`lodev-mysql`, client `mysql`) or MariaDB (`lodev-mariadb`, client `mariadb`) per `services`. Root password `root` (also `$MYSQL_ROOT_PASSWORD`/`$MARIADB_ROOT_PASSWORD`), e.g. `docker exec -i lodev-mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;"'`. DB name is usually the project name with `-`→`_`, sometimes `<name>_staging`; the app config (`.env`, `app/etc/env.php`, `wp-config.php`) is the truth; unsure → ask.
- Dumps: `lodev db-export`, `lodev db-import -f dump.sql`; run `lodev snapshot create` before anything risky.

## Local tools

On my machine, search text with `rg` (not `grep`) and find files with `fd` (not `find`/`ls -R`). For compound suffixes use `fd -g '*.test.ts'`, not `-e`.
