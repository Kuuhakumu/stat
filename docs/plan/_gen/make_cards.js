// Generates docs/plan/tasks/Txx.md lesson cards from lessons_a.tsv + lessons_b.tsv
const fs = require('fs'), path = require('path');
const gen = __dirname, out = path.join(gen, '..', 'tasks');
const rows = [];
for (const f of ['lessons_a.tsv', 'lessons_b.tsv'])
  for (const line of fs.readFileSync(path.join(gen, f), 'utf8').split(/\r?\n/))
    if (line.trim()) rows.push(line.split('\t'));
for (const [tid, fname, ch, pages, scope, research, tables] of rows) {
  const src = [];
  if (ch !== '-') {
    src.push(`- Slide images (authoritative): \`sources/pages/${ch}/\` pages ${pages}. Look at every page in the range.`);
    src.push(`- Slide text (symbols are broken, use only for Thai wording): \`sources/${ch}.txt\``);
  }
  src.push(`- Research: ${research}. Read the \`## Audit\` section first if the note has one.`);
  if (tables !== '-') src.push(`- Exam tables: ${tables} (+ \`sources/tables.txt\`). Quote values exactly as printed.`);
  src.push('- Earlier lessons in `beginner/` that this one builds on (skim headings only, reuse their wording and symbols, do not repeat their explanations — link to them).');
  const card = `# ${tid} — write \`beginner/${fname}\`

Read \`docs/plan/STYLE.md\` first and follow it exactly.

## Scope
${scope}

## Sources
${src.join('\n')}

## Write
- \`beginner/${fname}\` only (plus your line in \`docs/plan/PROGRESS.md\`).
- Use the lesson template in STYLE.md. Worked examples: every EX listed in the scope, with the EX number and slide page, using the 4-step recipe.
- Practice: at least 3 written + 3 multiple-choice questions with new numbers (not copies of the EX), answers with full working in \`<details>\`.
- \`## ไปต่อ\` links to the next lesson file listed in \`docs/plan/PLAN.md\`.

## Check before finishing
1. Recompute every number in your file with Node.js (\`node -e\` or a throwaway .js in \`%TEMP%\`, not in the repo; Python is not installed). Fix any mismatch.
2. Every table value you used is the printed value from the exam table.
3. Every symbol has been explained the first time it appears (or links to the lesson that explains it).
4. \`powershell -ExecutionPolicy Bypass -File tests/validate-beginner-guide.ps1\` passes.
5. Tick ${tid} in \`docs/plan/PROGRESS.md\` and add your log line.
`;
  fs.writeFileSync(path.join(out, tid + '.md'), card, 'utf8');
  process.stdout.write(tid + ' ');
}
