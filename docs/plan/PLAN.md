# Plan: Stat Final — Beginner Route (เส้นทางเริ่มจากศูนย์)

**Course:** KMITL 01476011 ความน่าจะเป็นและสถิติ — final exam, multiple choice, statistical tables provided.
**Scope:** CH4 (discrete & continuous distributions), CH5 (sampling & sampling distributions), CH6 (estimation), CH7 (hypothesis testing), the exam table booklet, and the end-of-chapter homework (แบบฝึกหัด CH4 p-50–55, CH6 p-33–36, CH7 p-46–48). CH3 is out of scope.
**Reader:** zero background, weak math, hasn't done the homework. Done = can solve every slide example + every homework problem + a mock exam **alone**.
**Model to copy:** `C:\study\final\security-midterm-master` (Thai-first beginner route, closed-book practice in `<details>`, glossary, last-few-hours page, validator, published on GitHub).
**Workers:** GPT 6.1 sol via Codex CLI, **one task card per fresh session** (`docs/plan/tasks/Txx.md`). Every session reads `docs/plan/STYLE.md` first. Progress lives in `docs/plan/PROGRESS.md`.

## How to run a task

- Automatic (runs the next unchecked task in a fresh Codex session):
  `powershell -ExecutionPolicy Bypass -File docs/plan/run-next-task.ps1`
- Manual: open a new Codex session in `C:\study\final\stat` and paste
  `Read docs/plan/STYLE.md, then do exactly the task in docs/plan/tasks/T05.md. Nothing else.`

Run tasks **in order** (the order in PROGRESS.md) — later lessons build on earlier ones; review tasks R1–R4 sit at the end of each chapter phase.

## Inputs already prepared (planning session)

- `materials/` original PDFs.
- `sources/CH4.txt … CH7.txt, tables.txt` — extracted text. **Greek symbols are lost** in it; never trust symbols from it.
- `sources/pages/<CH4|CH5|CH6|CH7|TABLES>/p-NN.png` — page images. **Authoritative.**
- `docs/research/CH4a, CH4b, CH5a, CH5b, CH6, CH7a, CH7b.md` — per-chapter notes: outline, formulas, every EX solved and recomputed, decision rules, prerequisites, traps, slide errors.
- `docs/research/TABLES.md` — how each exam table is read. `docs/research/HOMEWORK.md` — every homework problem transcribed, solved, checked against the slide เฉลย.

## Known slide issues (lessons must flag each with ⚠️)

- CH7 p-05 EX 7.1: text says "มากกว่า 60" but slide writes H₁: μ≠60 → should be μ>60.
- CH4 p-05: discrete-uniform mean printed μ=1/k → correct is μ=(1/k)Σxᵢ.
- CH4 p-12: binomial heading numbered "3.3" (just a numbering typo).
- CH5 p-38: μ_p̂ printed as μ → should be p.
- CH6 p-12: heading says population not normal, theorem text says normal (rule: n≥30 → use Z).
- CH6: no sample-size formula exists in the slides → don't teach one as course content.
- CH7 EX 7.7–7.16: no α and no worked answer on slides → lessons state "สมมติ α = 0.05" and decide at that α, and also show how the decision would change at α = 0.01.
- CH4 แบบฝึกหัดข้อ 4 answer key skips a sub-number; CH4 แบบฝึกหัดข้อ 6(3) is underspecified.
- **Homework answer keys verified wrong** (independent audit, `docs/research/HOMEWORK.md` → `## Audit`): CH4 ข้อ 5(3) key 0.2524 → correct 0.9212; CH6 ข้อ 6 key −0.052 to 0.142 → correct ≈ −0.051 to 0.111; CH7 ข้อ 3 key "ปฏิเสธ H₀" → correct "ไม่ปฏิเสธ H₀" (key used the one-tail value 1.717 instead of the two-tail 2.074). CH4 ข้อ 4(2) key 0.8649 is the exact binomial value; the Poisson table gives 0.8647 — teach both and say either can appear as a choice. CH6 ข้อ 2 keys come from rounding z to 2 decimals before using the table — teach that method (it is what the exam expects).
- t-table header says "Cum.prob" but the columns are right-tail areas.
- EX numbering duplicates (two "EX 5.5"; "ทฤษฎี 4.6" used three times; no EX 7.3) — refer to examples by EX number **and** slide page.

## Target structure

```
stat/
  README.md                       overview + routes by time left
  beginner/
    README.md                     route map (pass 1 understand, pass 2 practice)
    before-you-start.md           how to study, calculator, what exam looks like
    00-concept-map.md             the whole course as one story CH4→CH7
    01-math-toolkit.md            %, fractions, powers, √, Σ, n!, nCr, e^x, inequality words, rounding
    02-probability-and-random-variables.md  probability, random variable, discrete/continuous, E(X), Var, SD, complement
    03-discrete-uniform-and-bernoulli.md    EX 4.1–4.3
    04-binomial.md                EX 4.4–4.7 + binomial table
    05-poisson.md                 EX 4.8–4.12 + Poisson table + binomial≈Poisson
    06-continuous-uniform-and-exponential.md EX 4.13–4.16
    07-normal-and-z-table.md      Z=(X−μ)/σ, z table both directions, EX 4.17, 4.20
    08-normal-word-problems.md    EX 4.18, 4.19, 4.21
    09-homework-ch4.md            guided CH4 แบบฝึกหัด
    10-sampling-and-statistics.md CH5 p-01–23, EX 5.1–5.3
    11-sampling-distribution-of-mean.md  σ/√n, CLT, EX 5.4, 5.5(p-29), 5.8
    12-t-distribution.md          t, df, t table, EX 5.5(p-32), 5.6, 5.7
    13-sampling-distribution-of-proportion.md EX 5.9, 5.10
    14-difference-of-two-means.md EX 5.11–5.15 (Z, pooled t, Welch t)
    15-difference-of-two-proportions.md EX 5.16
    16-estimation-basics.md       point vs interval, confidence, α, Z_{α/2}, EX 6.1, 6.2
    17-ci-one-mean.md             EX 6.3–6.5
    18-ci-one-proportion.md       EX 6.6
    19-ci-two-means.md            EX 6.7–6.9
    20-ci-paired-and-two-proportions.md EX 6.10, 6.11
    21-homework-ch6.md            guided CH6 แบบฝึกหัด (covers CH5+CH6 skills)
    22-hypothesis-testing-idea.md H₀/H₁, Type I/II, α, β, power, tails, 5 steps, EX 7.1, 7.2
    23-test-one-mean.md           EX 7.4–7.7, critical value + p-value
    24-test-one-proportion.md     EX 7.8, 7.9
    25-test-two-means.md          EX 7.10–7.12
    26-test-paired.md             EX 7.13, 7.14
    27-test-two-proportions.md    EX 7.15, 7.16
    28-homework-ch7.md            guided CH7 แบบฝึกหัด
    29-choose-the-right-formula.md master flowchart (the key exam skill)
    30-exam-rehearsal.md          mock exam A (40 MCQ)
    31-exam-rehearsal-b.md        mock exam B (40 MCQ, different numbers)
    32-solo-homework.md           every homework problem, question only, answers hidden
    formula-sheet.md · tables-guide.md · glossary.md · last-few-hours.md · slide-coverage.md
  tests/validate-beginner-guide.ps1
  docs/research/ · docs/plan/ · docs/audit-report.md
```

## Phases and tasks

Each task = one fresh worker session = one card in `docs/plan/tasks/`. Cards say exactly which files to read and write.

| Phase | Tasks | Output |
|---|---|---|
| 0 Setup | T00 | folders, validator script, README skeletons, PROGRESS |
| 1 Foundations | T01 before-you-start · T02 concept map · T03 math toolkit · T04 probability & random variables | 4 files |
| 2 CH4 | T05 uniform/Bernoulli · T06 binomial · T07 Poisson · T08 continuous uniform/exponential · T09 normal & z table · T10 normal word problems · T11 homework CH4 · R1 review CH4 | lessons 03–09 |
| 3 CH5 | T12 sampling & statistics · T13 sampling dist. of mean · T14 t distribution · T15 proportion · T16 two means · T17 two proportions · R2 review CH5 | lessons 10–15 |
| 4 CH6 | T18 estimation basics · T19 CI one mean · T20 CI one proportion · T21 CI two means · T22 CI paired & two proportions · T23 homework CH6 · R3 review CH6 | lessons 16–21 |
| 5 CH7 | T24 testing idea · T25 test one mean · T26 test one proportion · T27 test two means · T28 test paired · T29 test two proportions · T30 homework CH7 · R4 review CH7 | lessons 22–28 |
| 6 Exam tools | T31 tables guide · T32 formula sheet · T33 choose-the-right-formula · T34 glossary | 4 files |
| 7 Practice | T35 mock exam A · T36 mock exam B · T37 solo homework · T38 last-few-hours | 4 files |
| 8 Finish | T39 slide-coverage map · T40 READMEs final · T41 full audit (read as a beginner) · T42 fix audit findings · T43 publish to GitHub | release |

Total: 48 small sessions (44 build T00–T43 + 4 phase reviews R1–R4). Roughly 15–30 min each. Runner: `docs/plan/run-next-task.ps1` (use `-Count 5` to chain several fresh sessions).

### Why this split

- **One concept family per lesson**, so a Sonnet-level worker holds the whole scope (≈ 10–15 slide pages + one research-note section) in one session.
- **Homework sits right after its chapter** as a *guided* lesson (full working), then reappears at the end as **solo** (answers hidden), so the reader proves they can do it alone.
- **Review tasks (R1–R4)** recompute every number in the phase with python, check against slides and tables, and fix errors immediately while the context is small. Mistakes in a stats guide are fatal — this is the main quality gate.
- **Exam tools come after the lessons**, so they summarize the real lessons instead of inventing new wording.
- Lesson numbering is fixed in advance, so links to future lessons can be written now.

## Definition of done

1. `powershell -ExecutionPolicy Bypass -File tests/validate-beginner-guide.ps1 -Final` passes (all files exist, every lesson has the template sections and `<details>` answers, required terms present, all links work, every EX and homework ID appears in `slide-coverage.md`).
2. R1–R4 and T41 audits are logged in `docs/audit-report.md` with no open "wrong number" items.
3. Every slide example (EX 4.1–7.16) and every homework problem is solved step-by-step somewhere in `beginner/`.
4. Repo published on GitHub (like `security-midterm-master`), private or public as the user chooses at T43.

## Risks

- **Wrong numbers / wrong table values** → review tasks recompute; STYLE requires printed-table values.
- **Worker drifts into academic Thai** → STYLE language rules + the T41 audit reads "as a beginner" and lists any sentence a ม.ปลาย student wouldn't understand.
- **Worker exceeds scope or edits others' files** → each card lists the allowed files; reviews diff against the scope.
- **Exam time** — if time runs out, the minimum useful set is T00–T04, the lessons, T33 and T38; mock exams can be skipped.
