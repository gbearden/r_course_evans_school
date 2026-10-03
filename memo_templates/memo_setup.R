# Shared setup for the memo templates. Each memo runs source("memo_setup.R")
# in its setup chunk. Works for both HTML memos (memo.css, memo_header.html)
# and LaTeX/PDF memos (memo_preamble.tex, memo_header.tex).

library(knitr)

opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE, dpi = 200)

# Memo header ---------------------------------------------------------------
# Fills the {{to}}, {{from}}, {{date}}, and {{re}} fields in the header file
# with the values in the memo's YAML `params`. HTML memos use
# memo_header.html; PDF memos use memo_header.tex.
memo_header <- function(params, template = NULL) {
  if (is.null(template)) {
    template <- if (is_latex_output()) "memo_header.tex" else "memo_header.html"
  }
  lines  <- readLines(template, warn = FALSE)
  lines  <- lines[!grepl("^\\s*%", lines)]  # drop LaTeX comment lines
  header <- paste(lines, collapse = "\n")
  for (field in names(params)) {
    header <- gsub(paste0("{{", field, "}}"), params[[field]], header, fixed = TRUE)
  }
  asis_output(header)
}

# Figure layout ---------------------------------------------------------------
# Add these chunk options to any plot chunk:
#   wrap = "right" or "left"  wraps the text that follows around the figure
#   wrap.width = 0.45         share of the page width the figure takes up
#   fig.width, fig.height     the plot's shape (inches) before it is scaled
# Without `wrap`, use fig.align = "center"/"left"/"right" and
# out.width = "70%" to align and size the figure on its own line.
# Keep the text after a wrapped figure at least as tall as the figure, or the
# next section will wrap around it too.
knit_hooks$set(plot = function(x, options) {
  if (is.null(options$wrap)) return(hook_plot_md(x, options))
  side  <- match.arg(options$wrap, c("right", "left"))
  width <- if (is.null(options$wrap.width)) 0.45 else options$wrap.width
  cap   <- if (is.null(options$fig.cap)) "" else options$fig.cap

  if (is_latex_output()) {
    sprintf(
      "\\begin{wrapfigure}{%s}{%.2f\\textwidth}\n\\centering\n\\includegraphics[width=\\linewidth]{%s}\n%s\\end{wrapfigure}\n",
      substr(side, 1, 1), width, x,
      if (cap == "") "" else sprintf("\\caption{%s}\n", cap)
    )
  } else {
    sprintf(
      '<figure class="wrap-%s" style="width: %d%%;"><img src="%s" alt="%s">%s</figure>\n',
      side, round(width * 100), x, cap,
      if (cap == "") "" else sprintf("<figcaption>%s</figcaption>", cap)
    )
  }
})
