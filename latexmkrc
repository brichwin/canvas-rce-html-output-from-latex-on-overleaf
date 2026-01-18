END {
  # Clean + create a stable output folder inside the project
  system("rm -rf make4ht-out");
  system("mkdir -p make4ht-out");

  # Uncomment if NOT using Bibtex: Run make4ht (jobname without .tex) and capture output
  system("make4ht -e mybuildnobibtex.mk4 -u -c a11y_canvas_html.cfg -d make4ht-out main > make4ht.log 2>&1");

  # Uncomment if USING Bibtex: Run make4ht (jobname without .tex) and capture output
  # system("make4ht -e mybuildwithbibtex.mk4 -u -c a11y_canvas_html.cfg -d make4ht-out main > make4ht.log 2>&1");

  # Copy key outputs into the project root so you can see them in Overleaf
  system("cp -f make4ht-out/main.html make4ht-out/main.css make4ht-out/main.bbl . 2>/dev/null");

  # Package everything useful for download
  system("zip -r make4ht-out.zip make4ht-out make4ht.log > /dev/null 2>&1");
  system("zip -r allfiles.zip . -x '*.cache*' > /dev/null 2>&1");
}
