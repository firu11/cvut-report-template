#let report-cover(
  title: "REPORT TITLE",
  subtitle: "REPORT SUBTITLE",
  author: "AUTHOR NAME",
  username: "STUDENT USERNAME",
  date: "DATE OF SUBMISSION (e.g. Květen 2026)",
  university: "Fakulta elektrotechnická ČVUT v Praze",
  branch: "YOUR STUDY BRANCH",
  logo: none,
) = {
  page(
    margin: 3cm,
    numbering: none,
  )[
    #set align(center)

    #stack(dir: ltr, spacing: 1.3em)[
      #logo
    ][
      #v(1.5em)
      #set align(left)
      #stack(dir: ttb, spacing: 12pt)[
        #text(university, size: 20pt, weight: "bold")
      ][
        #text(branch, size: 16pt)
      ]
    ]

    #align(horizon, block[
      #text(title, size: 26pt, weight: "bold")
      #v(-1.5em)
      #text(subtitle, size: 18pt)
    ])

    #align(bottom, block[
      #text(author, 18pt)\
      #text(username, 12pt)
      #v(1.5em)
      #text(date)
    ])
  ]
}

#let report-toc(
  title: "TABLE OF CONTENTS TITLE",
) = {
  // style headings based on level
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true) // space above
    text(it, weight: 700, size: 14pt)
  }
  show outline.entry.where(level: 2): it => {
    v(4pt) // space above
    text(it, weight: 500, size: 13pt)
  }
  show outline.entry.where(level: 3): it => {
    text(it, weight: 300, size: 12pt)
  }
  show outline.entry.where(level: 4): it => {
    text(it, weight: 300, size: 11pt)
  }

  page(
    numbering: none,
  )[
    #align(center, text(size: 18pt)[#title])
    #v(14pt)
    #outline(title: none, indent: 1.6em)
  ]
}

#let report(
  title: "REPORT TITLE",
  subtitle: "REPORT SUBTITLE",
  author: "AUTHOR NAME",
  username: "STUDENT USERNAME",
  date: "DATE OF SUBMISSION (e.g. Květen 2026)",
  university: "Fakulta elektrotechnická ČVUT v Praze",
  branch: "YOUR STUDY BRANCH",
  logo: none,
  toc-title: "TABLE OF CONTENTS TITLE",
  font: "libertinus serif", // typst default
  bib: none,
  body,
) = {
  set document(
    title: title,
    author: author,
  )

  set page(
    paper: "a4",
    margin: 2cm,
    numbering: "1",
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): it => block[#text(size: 18pt, it)]
  show heading.where(level: 2): it => block[#text(size: 16pt, it)]
  show heading.where(level: 3): it => block[#text(size: 14pt, it)]
  show heading.where(level: 4): it => block[#text(size: 12pt, it)]

  set par(justify: true, first-line-indent: 2em) // hezky "do bloku"

  // slightly larger space behind an image/figure
  show figure: it => {
    it
    v(0.4em)
  }

  // code block
  show raw.where(block: true): it => align(
    block(
      stroke: rgb("#ddd"),
      fill: rgb("#fafafa"),
      inset: 10pt,
      radius: 0.5em,
      above: 2em,
      below: 2em,
      it,
    ),
    center,
  )

  report-cover(
    title: title,
    subtitle: subtitle,
    author: author,
    username: username,
    date: date,
    university: university,
    branch: branch,
    logo: logo,
  )

  report-toc(
    title: toc-title,
  )

  // main document
  pagebreak(weak: true)
  counter(page).update(1)
  body // the actual text

  if bib != none {
    pagebreak(weak: true)
    set par(justify: false) // no align to block
    bib
  }
}
