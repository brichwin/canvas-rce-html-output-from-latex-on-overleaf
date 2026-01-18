END {
  system("rm -rf make4ht-out");
  system("mkdir -p make4ht-out");
  system("cp *.css ./make4ht-out");
  system("cp *.png ./make4ht-out");
  system("cp *.svg ./make4ht-out");
  
  # Uncomment if NOT using Bibtex: Run make4ht (jobname without .tex) and capture output
  #system("make4ht -e mybuildnobibtex.mk4 -u -c a11y_canvas_html.cfg -d make4ht-out main > make4ht.log 2>&1");

  # Uncomment if USING Bibtex: Run make4ht (jobname without .tex) and capture output
  system("make4ht -e mybuildwithbibtex.mk4 -u -c a11y_canvas_html.cfg -d make4ht-out main > make4ht.log 2>&1");

  # Package everything for download
  system("zip -r make4ht-out.zip make4ht-out make4ht.log > /dev/null 2>&1");
  system("zip -r allfiles.zip . -x '*.cache*' > /dev/null 2>&1");
}
