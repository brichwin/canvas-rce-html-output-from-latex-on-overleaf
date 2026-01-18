# canvas-rce-html-output-from-latex-on-overleaf

Example Overleaf LaTeX project that produces HTML output suitable for pasting into the Canvas LMS Rich Content Editor (RCE).

This Overleaf LaTeX project is set up so that each Overleaf compile (using pdfLaTeX) also runs **make4ht/TeX4ht** to generate:

- `make4ht-out/main.html` (the HTML)
- `make4ht-out/main.css` (TeX4ht-generated CSS)
- `make4ht-out/` images (e.g. SVG/PNG from TikZ and included graphics)
- `make4ht-out.zip` (a zip of the output folder for easy download)

## What’s in this repo

- `main.tex`, `references.bib`: example content
- `canvasmathstyle.sty`: Provides reusable theorem-like environments (definition/theorem/warning/etc.)
- `a11y_canvas_html.cfg`: TeX4ht config (HTML/MathJax/SVG, and some accessibility/formatting tweaks)
- `canvas.css`: additional styling meant to make the HTML look good in Canvas
- `latexmkrc`: Overleaf build hook that runs `make4ht` after the normal PDF build
- `mybuildnobibtex.mk4` / `mybuildwithbibtex.mk4`: make4ht build recipes (with/without BibTeX; configure which in `latexmkrc`)

## Import into Overleaf

1. Create a zip of this repository (download from GitHub, or zip the folder locally).
2. In Overleaf:
   - New Project
   - Upload Project
   - select the zip
3. Configure Overleaf project settings:
   - In Overleaf: **Menu → Settings → Compiler tab**
   - Ensure the **Main document** is `main.tex` (Overleaf usually detects this automatically).
   - **Compiler**: `pdfLaTeX`
   - **TeX Live version**: `2025`
   - **Compiler mode**: `Normal`

## Configure `latexmkrc` (BibTeX vs no BibTeX)

This project uses `latexmkrc` to run `make4ht` after the normal Overleaf PDF build finishes.

Open `latexmkrc` and choose *exactly one* of the two `make4ht` lines in the `END { ... }` block:

- If your document **does not** have a bibliography, use `mybuildnobibtex.mk4`.
- If your document **does** use BibTeX (e.g. `\\bibliographystyle{...}` + `\\bibliography{...}` like `main.tex`), use `mybuildwithbibtex.mk4`.

Concretely:

1. Comment out the “NOT using Bibtex” line.
2. Uncomment the “USING Bibtex” line.

After changing `latexmkrc`, click **Recompile** again.

## Where the HTML output goes

On each successful compile, `latexmkrc`:

- regenerates `make4ht-out/`
- copies the .css, .png, and .svg files into `mke4ht-out/`
- writes `make4ht.log`
- creates two zip files:
  - `make4ht-out.zip` (just the HTML output folder)
  - `allfiles.zip` (the whole project, excluding caches)

## Download the HTML, CSS, and images from Overleaf

1. In Overleaf, click **Logs and output files** ("document" icon to the right of the Recompile button).
2. Look for **Other logs & files** (usually in the window's bottom right corner).
3. Download one of:
   - `make4ht-out.zip` (recommended for publishing the generated HTML)
   - `allfiles.zip` (recommended if you also want the full source project)

After downloading:

- Unzip `make4ht-out.zip`.
- Your generated files are inside `make4ht-out/`:
  - `main.html`
  - `main.css`
  - image files referenced by the HTML (SVG/PNG/etc.)
  - any other .css and imgage files in the source project

## Tips for using the HTML in Canvas

- Keep the HTML and the css and image files together; the HTML uses relative image paths to the same folder as the .html file.
- Canvas will strip some HTML/CSS code in the file depending on your institution’s settings. You will need to inline the CSS into the element `style` attributes if using the HTML in the Canvas RCE. See the [Canvas HTML Uploader (designed for uploading make4ht content)](https://github.com/brichwin/canvas-rce-html-uploader) repo for a tool
that automates this.

## Troubleshooting

- **No `make4ht-out.zip` appears**: 
  - check `make4ht.log` in Overleaf’s file list (or in “Other logs & files”) to see why `make4ht` failed.
  - `make4ht` will fail if bibtex in latexmkrc is selected but none are in the source .tex file.
- **Bibliography missing in HTML**: ensure you are using `mybuildwithbibtex.mk4` in `latexmkrc`.
