// Generates exam-tool / practice cards T31–T38 from tools.tsv
const fs = require('fs'), path = require('path');
const out = path.join(__dirname, '..', 'tasks');
for (const line of fs.readFileSync(path.join(__dirname, 'tools.tsv'), 'utf8').split(/\r?\n/)) {
  if (!line.trim()) continue;
  const [tid, fname, scope, sources, file] = line.split('\t');
  fs.writeFileSync(path.join(out, tid + '.md'), `# ${tid} — write \`beginner/${fname}\`

Read \`docs/plan/STYLE.md\` first and follow its language and number rules.

## Scope
${scope}

## Sources
${sources}. The lessons were already reviewed (R1–R4): when they disagree with the research notes, **trust the lessons**, but report the disagreement in your log line.

## Write
- \`${file}\` only (plus your line in \`docs/plan/PROGRESS.md\`).
- Link every item back to the lesson that teaches it (relative links).

## Check before finishing
1. Recompute every number with Node.js (Python is not installed); table values must be the printed ones.
2. \`powershell -ExecutionPolicy Bypass -File tests/validate-beginner-guide.ps1\` passes.
3. Tick ${tid} in \`docs/plan/PROGRESS.md\` and add your log line.
`, 'utf8');
  process.stdout.write(tid + ' ');
}
