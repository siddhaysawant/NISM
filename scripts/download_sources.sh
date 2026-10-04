#!/usr/bin/env bash
# Download the official NISM Series XV (Research Analyst) and SEBI source files
# into nism/ and sebi/. Run from the repo root:  bash scripts/download_sources.sh
#
# Needs network access to www.nism.ac.in and www.sebi.gov.in.
set -u

cd "$(dirname "$0")/.."
UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128 Safari/537.36"
MANIFEST="SOURCES.tsv"
[ -f "$MANIFEST" ] || printf "file\turl\tfetched_utc\tstatus\n" > "$MANIFEST"

fetch() {
  local out="$1" url="$2"
  mkdir -p "$(dirname "$out")"
  local code
  code=$(curl -sSL --retry 3 --max-time 120 -A "$UA" -o "$out" -w '%{http_code}' "$url" 2>/dev/null)
  code=${code:-000}
  if [ "$code" = "200" ] && [ -s "$out" ]; then
    echo "ok    $out"
  else
    echo "FAIL  $out  (HTTP $code)  $url"
    rm -f "$out"
  fi
  printf "%s\t%s\t%s\t%s\n" "$out" "$url" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$code" >> "$MANIFEST"
}

# --- NISM: exam pages (HTML) ---
fetch nism/research-analyst-exam-page.html     "https://www.nism.ac.in/research-analyst-certification-examination/"
fetch nism/research-analyst-faq.html           "https://www.nism.ac.in/frequently-asked-questions-research-analyst"
fetch nism/test-objectives-2026-01-20.html     "https://www.nism.ac.in/test-objectives-research-analyst-w-e-f-january-20-2026"
fetch nism/communique-2025-12-05.html          "https://www.nism.ac.in/circular/nism-certification-nism-series-xv-research-analyst-certification-examination-2025-dated-december-05-2025/"
fetch nism/xv-b-renewal-exam-page.html         "https://www.nism.ac.in/nism-series-xv-b-research-analyst-certification-renewal-examination/"

# Any PDFs linked from those NISM pages (test objectives, workbook, circulars)
for page in nism/*.html; do
  [ -f "$page" ] || continue
  grep -oiE 'href="[^"]+\.pdf"' "$page" | sed -E 's/^href="//I; s/"$//' | sort -u | while read -r pdf; do
    case "$pdf" in http*) ;; /*) pdf="https://www.nism.ac.in$pdf" ;; *) continue ;; esac
    fetch "nism/pdf/$(basename "${pdf%%\?*}")" "$pdf"
  done
done

# --- SEBI: regulations, FAQ, circulars (PDF) ---
fetch sebi/ra-regulations-2014-gazette.pdf      "https://www.sebi.gov.in/sebi_data/commondocs/RESEARCHANALYSTS-regulations_p.pdf"
fetch sebi/ra-regulations-faq.pdf               "https://www.sebi.gov.in/sebi_data/attachdocs/1418122025732.pdf"
fetch sebi/ra-circular-2025-105.pdf             "https://www.sebi.gov.in/sebi_data/faqfiles/jul-2025/1753269723942.pdf"
fetch sebi/ra-regulations-page.html             "https://www.sebi.gov.in/legal/regulations/sep-2014/sebi-research-analysts-regulations-2014_27895.html"

echo
echo "Workbook: NISM serves the official Series XV workbook PDF only after a form at"
echo "  https://api.nism.ac.in/cmp/  (name, email etc.). Download it there and save it as"
echo "  nism/NISM-Series-XV-Research-Analyst-Workbook.pdf"
