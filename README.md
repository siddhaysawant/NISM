# NISM Series XV — Research Analyst exam material

Study material and official sources for the NISM-Series-XV: Research Analyst Certification Examination (SEBI RA Regulations, 2014).

| Path | What |
| --- | --- |
| `artifact/research-analyst-exam-guide.md` | Exam guide: pattern, fees, syllabus weightage, 15-unit syllabus map, study plan, sources |
| `nism/` | Official NISM pages and PDFs (workbook, test objectives, communiqués) |
| `sebi/` | SEBI (Research Analysts) Regulations 2014, SEBI FAQ, RA circulars |
| `scripts/download_sources.sh` | Fetches everything in `nism/` and `sebi/` from the official sites |
| `SOURCES.tsv` | Written by the script: each file's source URL and download time |

## Getting the files

```bash
bash scripts/download_sources.sh
```

Needs access to `www.nism.ac.in` and `www.sebi.gov.in`.

### Official workbook PDF

NISM gives the workbook free, but only through a form:

1. Go to <https://api.nism.ac.in/cmp/> and fill in your details.
2. Choose **NISM-Series-XV: Research Analyst**, February 2026 edition or later (the syllabus changed from 20 January 2026).
3. Save it as `nism/NISM-Series-XV-Research-Analyst-Workbook.pdf`.

NISM also emails the soft copy after you enrol for the exam at <https://cert.nism.ac.in/>.

## Key official links

- NISM Research Analyst exam: <https://www.nism.ac.in/research-analyst-certification-examination/>
- NISM FAQ: <https://www.nism.ac.in/frequently-asked-questions-research-analyst>
- Test objectives (from 20 Jan 2026): <https://www.nism.ac.in/test-objectives-research-analyst-w-e-f-january-20-2026>
- SEBI RA Regulations 2014: <https://www.sebi.gov.in/legal/regulations/sep-2014/sebi-research-analysts-regulations-2014_27895.html>
- SEBI FAQ on RA Regulations: <https://www.sebi.gov.in/sebi_data/attachdocs/1418122025732.pdf>
