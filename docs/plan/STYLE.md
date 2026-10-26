# STYLE — rules every worker session must follow

You are writing ONE piece of a Thai beginner study guide for KMITL 01476011 Probability & Statistics (final exam, multiple choice, all statistical tables are provided in the exam). The reader has **never studied statistics, is weak at math, and has not done any homework**. The goal: after the guide they can solve every exam-style question **alone**.

Model to copy: `C:\study\final\security-midterm-master\beginner\` (read 1 lesson there, e.g. `03-impact-and-consequences.md`, to see the tone and layout). It worked very well.

## Language
- Write in **Thai, everyday spoken-level**. Short sentences. No academic phrasing. Imagine explaining to a friend from high school (ม.ปลาย) who hates math.
- English term appears once in parentheses the first time, e.g. ค่าเฉลี่ยของตัวอย่าง (sample mean). After that use the Thai word or the symbol.
- **Every symbol** must be introduced with: how to read it aloud + what it means in plain words. Example: `x̄` อ่านว่า "เอ็กซ์บาร์" = ค่าเฉลี่ยของข้อมูลที่เราเก็บมาจริง.
- Story/picture first → then the rule → then the formula → then a worked example. Never start a section with a formula.
- Do not skip arithmetic steps. Show every substitution and every intermediate number. Show what to press on a calculator when it's not obvious (√, x², ÷ inside brackets).
- Math as Unicode (μ σ σ² x̄ p̂ ≤ ≥ ≠ √ Σ α Z_{α/2}); put multi-line calculations inside ```text code blocks. No LaTeX.

## Numbers must be correct
- Use the research notes in `docs/research/` (they recomputed every slide example) plus the page images in `sources/pages/<CH>/p-NN.png` (authoritative). Check `## Audit` sections in research notes first — they contain corrections.
- Values read from tables must be **the exact 4-digit (or 3-digit) value printed in the exam table** (`sources/tables.txt`, `sources/pages/TABLES/`), not a more precise computer value. Students will only have the printed table.
- Recompute every number you write with **Node.js** before saving (`node -e "..."` or a throwaway .js in %TEMP%; Python is NOT installed on this PC). If your result differs from the slide, keep the correct one and add a box:
  `> ⚠️ สไลด์หน้า p-NN เขียนว่า ... แต่ที่ถูกคือ ... เพราะ ...`

- Rounding rule (matches the slide keys): round z to **2 decimals** before reading the Z table; give final probabilities to 4 decimals. If the exact value differs from the table value, show the table value as the answer and mention the exact one in one short line.

## Lesson file template (files `beginner/NN-*.md`)
```
# บทที่ NN: <ชื่อเรื่องภาษาคน>
## เป้าหมาย            (2–4 bullets: "หลังจบบทนี้คุณจะ…")
## ต้องรู้ก่อน          (links to earlier lessons)
## นึกภาพก่อน          (everyday story/analogy, no formula)
## <concept sections>  (rule → formula + symbol table | สัญลักษณ์ | อ่านว่า | หมายถึง |)
## ตัวอย่างจากสไลด์ทำทีละขั้น   (every EX in scope, cite "EX 4.5 (สไลด์ CH4 หน้า 16)")
## วิธีอ่านตาราง        (only if a table is used: which page, row, column, picture of shaded area in words)
## กับดักในข้อสอบ       (traps from research §6, each with the wrong vs right thinking)
## แบบฝึกหัดปิดหนังสือ  (≥3 written questions + ≥3 multiple-choice with 4 choices ก ข ค ง; answers + full working inside <details><summary>เปิดดูเฉลย</summary> … </details>)
## สรุปจำสั้น           (≤8 bullets or a small table)
## ไปต่อ               (link to next lesson)
```
- Each worked example uses the fixed 4-step recipe: **1) โจทย์ถามอะไร / ข้อมูลที่มี → 2) คำใบ้ในโจทย์บอกว่าใช้วิธีไหน (และเพราะอะไร) → 3) คำนวณทีละบรรทัด → 4) แปลผลเป็นภาษาคน**.
- Multiple-choice practice: wrong choices must be the *typical mistakes* (wrong tail, forgot √n, used n instead of n−1, Z instead of t …) and the เฉลย explains why each wrong choice is wrong.
- Length target: 150–350 lines. If it gets longer, you are explaining things outside your scope.

## Session discipline
- Do **only your one task card**. Touch only the files the card lists (plus `docs/plan/PROGRESS.md`).
- **Never delete, move or rename any file you did not create in this session** — other files (research notes, earlier lessons) belong to other sessions even if they look like leftovers. Do not spawn sub-agents.
- Relative Markdown links only; link targets must exist (if a later lesson doesn't exist yet, still link it by its planned filename from `docs/plan/PLAN.md` — the validator only checks links in `-Final` mode).
- Finish by running: `powershell -ExecutionPolicy Bypass -File tests/validate-beginner-guide.ps1` (after task T00 creates it) and fix any error.
- Then in `docs/plan/PROGRESS.md`: tick your task `[x]` and append one line to the log: `- <date> <ID>: <one-sentence summary>; issues: <none|…>`.
- If something in your card is impossible or the sources contradict, do your best, and write the problem in the log line instead of guessing silently.
