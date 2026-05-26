#set document(
  title: "Wie man als Vater mehr als zwei Monate Karenz nimmt - oder anderweitig mehr Verantwortung übernimmt in den ersten Jahren mit Kind ",
  author: "Matthias Andrasch für karenz-wizard.at",
)

#let version-info = "Version: Erster Entwurf v0.1 (Mai 2026)"

#set page(
  paper: "a4",
  margin: (x: 2.2cm, top: 2.4cm, bottom: 4.0cm),
  footer: context [
    #line(length: 100%, stroke: 0.5pt + luma(205))
    #v(4pt)
    #set text(size: 8pt, fill: luma(105))
    #grid(
      columns: (1fr, auto, 1fr),
      align: (left + horizon, center + horizon, right + horizon),
      link("https://karenz-wizard.at")[karenz-wizard.at],
      version-info,
      [Seite: #counter(page).display()],
    )
  ],
)

#set text(
  lang: "de",
  size: 11pt,
  // "Inter" = Brand-Schrift der Website (gevendored in typst/fonts,
  // per --font-path eingebunden). "Noto Emoji" (statisch, monochrom)
  // liefert die 💰 / ⚠️ Glyphen im PDF.
  font: ("Inter", "Noto Emoji"),
)

// Mehr Luft: groesseres Zeilen- und Absatz-Spacing
// (par.spacing ist der moderne Absatz-Abstand ab Typst 0.11)
#set par(leading: 0.8em, spacing: 1.4em, justify: true)

#set heading(numbering: none)
// Mehr Abstand unter Ueberschriften
#show heading: set block(above: 1.4em, below: 1.4em)
#show heading.where(level: 2): set block(below: 1.6em)
#show heading.where(level: 1): set text(size: 16pt)
#show heading.where(level: 2): set text(size: 13pt)
#set list(indent: 6pt)

// "OPTION N"-Overline automatisch ueber den Options-Ueberschriften (Ebene 2
// im Kapitel <optionen-kapitel>). Nummerierung laeuft synchron zum Mini-TOC,
// weil dieselbe Sammel-Logik (Anker = Label <optionen-kapitel>) genutzt wird.
#show heading.where(level: 2): it => context {
  let hs = query(heading)
  let collecting = false
  let opts = ()
  for h in hs {
    if h.level == 1 {
      if collecting { break }
      if "label" in h.fields() and h.label == <optionen-kapitel> { collecting = true }
    } else if h.level == 2 and collecting {
      opts.push(h)
    }
  }
  let pos = it.location().position()
  let idx = none
  for (i, o) in opts.enumerate() {
    if o.location().position() == pos { idx = i + 1; break }
  }
  if idx == none {
    it
  } else {
    block(above: 1.4em, below: 1.6em, sticky: true, {
      text(size: 9pt, weight: "bold", fill: rgb("#F99435"))[OPTION #idx]
      // Overline tight an die Ueberschrift koppeln, Abstand danach via Aussen-Block
      set block(above: 0.7em, below: 0pt)
      it
    })
  }
}

// Links sichtbar machen: unterstrichen + Akzentfarbe (gut auch fuer SW-Druck)
#show link: it => underline(text(fill: rgb("#F99435"), it))



// ---- CUSTOM INFOBOXEN ----

// Finanzbox mit Geldsack-Emoji
#let finanzbox(titel, inhalt) = {
  block(
    width: 100%,
    fill: rgb("#f0fdf4"), // Sanftes Grün
    inset: 12pt,
    radius: 4pt,
    stroke: (left: 4pt + rgb("#16a34a")), // Grüner Balken links
    [
      #text(weight: "bold", fill: rgb("#16a34a"))[💰 #titel] \
      #v(4pt)
      #inhalt
    ]
  )
}

// Gelbe Warnungs-/Achtung-Box (Bernstein)
#let warnboxgelb(titel, inhalt) = {
  block(
    width: 100%,
    fill: rgb("#fffbeb"), // Sanftes Gelb
    inset: 12pt,
    radius: 4pt,
    stroke: (left: 4pt + rgb("#f59e0b")), // Gelb-/Bernsteinbalken links
    [
      #text(weight: "bold", fill: rgb("#b45309"))[⚠️ #titel] \
      #v(4pt)
      #inhalt
    ]
  )
}

// Fristen- / Warnungs-Box (Rot)
#let fristbox(titel, inhalt) = {
  block(
    width: 100%,
    fill: rgb("#fef2f2"), // Sanftes Rot
    inset: 12pt,
    radius: 4pt,
    stroke: (left: 4pt + rgb("#dc2626")), // Roter Balken links
    [
      #text(weight: "bold", fill: rgb("#dc2626"))[⚠️ #titel] \
      #v(4pt)
      #inhalt
    ]
  )
}

// Neutrale Hinweis- / Einordnungs-Box (Grau, dezent)
#let hinweisbox(titel, inhalt) = {
  block(
    width: 100%,
    fill: luma(245),
    inset: 12pt,
    radius: 4pt,
    stroke: (left: 4pt + luma(160)), // Grauer Balken links
    [
      #text(weight: "bold", fill: luma(70))[#titel] \
      #v(4pt)
      #inhalt
    ]
  )
}

// QR-Box: kleiner schwarz/weisser QR-Code + Titel + Link (toner-sparsam).
//    QR via Paket "tiaoma" (wird beim ersten Compile in den Typst-Cache
//    geladen; CI hat Netzzugang).
//    Nutzung:  #qrbox("https://...")[Titel]
//              #videoqr("https://youtu.be/ID")[Titel]
#import "@preview/tiaoma:0.3.0"
#let qrbox(url, titel, hinweis: "Per Smartphone-Kamera scannen oder:") = {
  block(
    width: 100%,
    inset: 10pt,
    radius: 4pt,
    fill: luma(248),
    grid(
      columns: (auto, 1fr),
      column-gutter: 12pt,
      align: (center + horizon, left + horizon),
      box(width: 2cm, tiaoma.qrcode(url)),
      [
        #text(weight: "bold", fill: luma(70))[#titel] \
        #v(2pt)
        //#text(size: 9pt, fill: luma(105))[#hinweis] \
        #link(url)[#text(size: 9pt, fill: rgb("#F99435"))[#url]]
      ],
    )
  )
}

#let videoqr(url, titel) = qrbox(url, [Video-Tipp: #titel])

// ============================================================
//  COVER
// ============================================================
#page(footer: none, margin: (left: 3cm, right: 3cm, top: 3.2cm, bottom: 3cm))[
  #set par(justify: false, leading: 0.6em, spacing: 0.4em)
  // Diagonales Entwurf-Wasserzeichen (liegt unabhaengig ueber der Seite)
  //#place(center + horizon, rotate(-45deg, text(size: 92pt, weight: "bold", fill: luma(0).transparentize(85%))[ENTWURF]))
  #grid(
    rows: (1fr, auto, 1fr),
    // --- oben: Kicker ---
    align(top + left)[
      #text(size: 11pt, fill: rgb("#F99435"), weight: "bold", tracking: 1.2pt)[
       RATGEBER
      ]
    ],
    // --- Mitte: Titel + Akzentlinie + Untertitel (linksbuendig) ---
    align(horizon + left)[
      #text(size: 30pt, weight: "bold")[
        Wie man als Vater mehr als zwei Monate Karenz nimmt
      ]
      // Untertitel direkt unter dem Titel (kleiner + leichter, linksbuendig)
      #v(12pt)
      #text(size: 16pt, fill: luma(95), weight: "regular")[
       \- oder anderweitig mehr Verantwortung übernimmt
        in den ersten Jahren mit Kind.
      ]
      // Akzentlinie als Abschluss unter Titel + Untertitel
      #v(20pt)
      #line(length: 16%, stroke: 3pt + rgb("#F99435"))
      #v(20pt)
      #text(size: 13pt, fill: luma(95), weight: "regular")[
       Ein Mini-Ratgeber für Väter in Österreich
      ]
    ],
    // --- unten: Wortmarke + kleines Maskottchen ---
    align(bottom + center)[
      #grid(
        columns: 1,
        row-gutter: 8pt,
        align: center,
        image("assets/logo.png", width: 2cm),
        link("https://karenz-wizard.at")[
          #text(fill: rgb("#F99435"), weight: "bold", size: 13pt)[karenz-wizard.at]
        ],
        v(4pt),
        version-info,
      )
    ],
  )
]

// ============================================================
//  IMPRESSUM / STAND (eigene Seite nach dem Cover)
// ============================================================
#page(footer: none, margin: 2.4cm)[
  #set par(leading: 0.7em, justify: false)

  #v(42pt)

  // TODO: only globally needed?
  #set quote(block: true)
  #quote(
    attribution: [Ergebnisbericht Eltern-Umfrage von Bernhard Herzog, 2026 \ https://www.spoe.at/elternkarenz-ergebnisse/],
  )[
    #set text(size: 13pt)
    „Vieles von dem, was Väter heute erstmals als Hürde erleben, ist für Frauen am Arbeitsmarkt seit Jahrzehnten Realität.“
  ]

  #v(1fr)

  #text(size: 11pt)[#version-info]

  #v(12pt)

  *+++ Entwurf zur öffentlichen Kommentierung +++*

  Dies ist noch ein Entwurfstext. Kritisches Anmerkungen, allgemeines Feedback oder weitere Cases / Möglichkeiten sehr gerne an mich per Mail schicken. Vielen Dank! 

  E-Mail: #link("mailto:matthias-andrasch-kontakt@mailbox.org")[matthias-andrasch-kontakt\@mailbox.org]

  *Keine Rechts-, Steuer- oder Sozialberatung*

  Dieser Ratgeber ist ein privates,
    nichtkommerzielles Hobbyprojekt. Alle Angaben ohne Gewähr. Die Informationen sind 
    unverbindlich und können ggf. unvollständig, fehlerhaft oder veraltet sein. Es handelt sich *nicht* um eine  individuelle Rechts-, Steuer- oder Sozialberatung. Für
    verbindliche Auskünfte und vor jeder Antragstellung wende dich bitte unbedingt an
    die zuständigen Stellen und lass dich beraten (Arbeiterkammer, ÖGK, Gewerkschaft / Betriebsrat, etc.).

  *Lizenz: CC0 / Public Domain*

  #link("https://creativecommons.org/publicdomain/zero/1.0/")[
    #image("assets/cc-zero.png", width: 2.6cm)
  ]

  Autor: Matthias Andrasch für karenz-wizard.at \
  Freigeben als #link("https://creativecommons.org/publicdomain/zero/1.0/")[https://\u{200B}creativecommons.org/\u{200B}publicdomain/\u{200B}zero/\u{200B}1.0]

  Erstellt und generiert mit der Open Source Software #link("https://github.com/typst/typst")[typst]. Der Quelltext dieses Ratgebers ist auf GitHub abrufbar (#link("https://github.com/mandrasch/karenz-wizard")[github.com/mandrasch/karenz-wizard]).
]

// TODO: Größtes Problem noch - ist für eaKBG geschrieben, für alle schreiben? Oder vom "Durchschnittsfall" ausgehen?

// ============================================================
//  INHALTSVERZEICHNIS (eigene Seite, VOR dem Prolog)
// ============================================================

#page(footer: none, margin: (x: 2.2cm, top: 2.4cm, bottom: 4.0cm))[
  #heading(outlined: false)[Inhalt]
  #v(6pt)
  #outline(title: none, depth: 2, indent: auto)
  #v(50pt)
  #hinweisbox("Ganz neu im Thema Kinderbetreuungsgeld und Karenz?")[
  Schau dir am besten zuerst den #link(<crashkurs>)[Crashkurs Kinderbetreuungsgeld] hinten im Ratgeber an. Dort sind die Grundlagen kurz erklärt und hilfreiche Arbeiterkammer-Videos verlinkt. Auf #link("https://karenz-wizard.at")[karenz-wizard.at] gibt es zudem eine Schritt-für-Schritt Übersicht.
]
]

// Inhalt beginnt -> Seitenzaehler auf 1 (Cover/Impressum/Inhalt/Prolog
// sind Frontmatter ohne Seitenzahl).
#counter(page).update(1)

= Warum ich diesen Ratgeber geschrieben habe

„Wie nimmt man als Vater denn verdammt nochmal mehr als 2 Monate Karenz?”  

Diese Frage hat mir einige schlaflose Nächte bereitet.

Angefangen hat alles mit dem legitimen Wunsch meiner Partnerin bei der ersten gemeinsamen Planung: Sie wollte das erste
Lebensjahr mit unserem Kind zu Hause zu erleben. Mit den Details zu
Kinderbetreuungsgeld und Karenz hatten wir uns da noch gar nicht
beschäftigt. 

Zur selben Zeit las ich immer wieder in Medienberichten: „Väter
nehmen nur zwei Monate Karenz in Österreich — wenn überhaupt“. Und dass Österreich zu den EU-weiten Schlusslichtern bei der Väterkarenz gehört. Während Mütter 12 bis 24 Monate übernehmen.

Das saß. Ich wollte ein moderner Vater sein und gleichberechtigte
Elternschaft wirklich versuchen. Kein Super-Dad - aber eben einer, der seine Partnerin nicht allein lässt mit Betreuung, Mental Load & Co.

Mein Vorsatz war klar: Bloß nicht so ein "Zwei-Monate-Vater" werden!

Doch schnell stellte sich raus, dass das einkommensabhängige Kinderbetreuungsgeld vom Staat nur
für maximal 14 Monate ausgezahlt wird, ab Geburt. Es beträgt ca. 80% des vorherigen Einkommens. Nimmt meine Partnerin davon also zwölf Monate, bleiben mir — genau, richtig erkannt — die medial viel kritisierten zwei Monate.

Heute weiß ich: Ruhig bleiben, die Karenzaufteilung ist nicht alles! 

Wer es sich leisten kann, hat Optionen wie das Anhängen von unbezahlten Karenzmonaten - sogar mit rechtlichem Anspruch auf Karenz-Freistellung bis zum 2. Lebensjahr. 

Aber auch nach der Karenz gibt es Optionen wie die Eltern-Teilzeit (falls Anspruch besteht), bei der man als Vater echte Verantwortung übernehmen kann. Neben vielen weiteren Optionen für mehr Väterbeteiligung.

Diese Möglichkeiten habe ich nun hier versucht kurz & knackig zu sammeln. Auch, weil ich so eine Übersicht damals schmerzlich vermisst
habe.

Viel Erfolg beim Finden deines / euren individuellen Weges!

#v(12pt)
#grid(
  columns: (auto, 1fr),
  column-gutter: 10pt,
  align: (horizon, horizon),
  box(clip: true, radius: 50%, image("assets/avatar.png", width: 2cm)),
  [
    #text(weight: "bold")[Matthias Andrasch] \
    #text(size: 9pt, fill: luma(110))[karenz-wizard.at]
  ],
)

#pagebreak()



= Deine Optionen für mehr als zwei Monate Karenz
<optionen-kapitel>

// Der Ausgangspunkt, von dem wir starten:

Jetzt geht es ans Eingemachte. Ich gehe in diesem Ratgeber davon aus, dass ...

- ihr im *gemeinsamen Haushalt lebt*
- und *mindestens einer von euch Anspruch auf einkommensabhängiges Kinderbetreuungsgeld (eaKBG)*\* hat

#qrbox("https://karenz-wizard.at/eakbg-anspruch/")[eaKBG-Anspruch prüfen: Die 182-Tage-Regel]

Die besondere Herausforderung:  Das einkommensabhängige Kinderbetreuungsgeld (eaKBG)
wird *maximal 14 Monate ab Geburt* vom Staat ausgezahlt, wenn der Vater mindestens 2 Monate nimmt.

Wünscht sich die Mutter die ersten *12 Monate*, bleiben für den Vater nur die - medial viel
kritisierten - *zwei Monate* mit guter Bezahlung vom Staat. 

Genau an diesem Punkt setzen einige der folgenden Optionen an, aber nicht alle.

#text(size: 9pt, style: "italic")[\* Falls ihr beide keinen Anspruch auf das einkommensabhängige Kinderbetreuungsgeld habt, könnt ihr das pauschale Kinderbetreuungsgeld beziehen - hier gibt es keine Limitierung auf 14 Monate, jedoch leider weniger Geld. Optionen wie die Eltern-Teilzeit sind aber davon unabhängig nutzbar. Schaut also einfach mal durch!]

#v(12pt)
*Die Optionen im Überblick*
#v(6pt)
// Auto-generiertes Boxen-Menue: sammelt die Options-Unterkapitel (Ebene 2)
// im Kapitel "Deine Optionen" (erstes ausgewiesenes Kapitel, outlined)
// und stellt sie als verlinkte Boxen dar. Bleibt synchron bei
// Umbenennung/Ergaenzung der Optionen.
#context {
  let hs = query(heading)
  let collecting = false
  let opts = ()
  for h in hs {
    if h.level == 1 {
      if collecting { break }
      if "label" in h.fields() and h.label == <optionen-kapitel> {
        collecting = true
      }
    } else if h.level == 2 and collecting {
      opts.push(h)
    }
  }
  for (i, opt) in opts.enumerate() {
    block(
      width: 100%,
      fill: luma(247),
      inset: (x: 12pt, y: 7pt),
      radius: 4pt,
      stroke: (left: 3pt + rgb("#F99435")),
      below: 6pt,
      link(opt.location())[
        #text(size: 9pt, weight: "bold", fill: rgb("#F99435"))[OPTION #(i + 1)]#h(10pt)#text(weight: "bold", fill: luma(35))[#opt.body]
      ],
    )
  }
}

#pagebreak()


== Mutter nimmt weniger als 12 eaKBG-Monate, Vater mehr als zwei

Dies ist eine der Varianten ohne finanzielle Abstriche, falls ihr Anspruch auf das einkommensabhängige Kinderbetreuungsgeld (eaKBG) habt und du mehr (bezahlte) Väterkarenz machen willst:

Die *Mutter nimmt weniger als 12 Monate eaKBG* in Anspruch, dem *Vater bleiben somit mehr bezahlte Karenzmonate (von den insgesamt 14 Monaten eaKBG ab Geburt)*.

So ist also auch eine *10+4* oder *8+6* Aufteilung möglich - bis hin zu *7+7, oder Aufteilungen bei denen der Vater mehr Karenz übernimmt*.


#qrbox("https://karenz-wizard.at/eakbg-planer/")[Aufteilung interaktiv ausprobieren: eaKBG-Planer]

=== Beispiel mit 3 Monaten Karenz der Mutter, deutlich längere Väterkarenz

// TODO: Freigabe einholen, Vater also 24 Monate?

Ines Eschbacher, vom Podcast #link("https://www.instagram.com/vereinbarkeitnext.podcast/")[Vereinbarkeit Next], berichtet auf #link("https://www.linkedin.com/feed/update/urn:li:activity:7459178598302916608/?dashCommentUrn=urn%3Ali%3Afsd_comment%3A%287463655469090521088%2Curn%3Ali%3Aactivity%3A7459178598302916608%29")[LinkedIn]:

  #set quote(block: true)
  #quote(
  )[
    Mein Mann ging 2x für 12 Monate in Karenz, während ich nach 3 Monaten zurück in meinen Vollzeit-Job ging. 
Wer mehr gefeiert wurde, kann man jetzt raten. (spoiler: ich war’s nicht!) 
Ich finde, gleichberechtigte Elternschaft ist muss das Zielbild für unsere Zukunft sein.
  ]


=== Rückkehr in den Job als zentrales Thema

Das Thema "Rückkehr in den Job" ist hier zentral für die Mutter. Zu beachten ist hier natürlich, dass Stillen/Abpumpen - falls möglich / gewünscht - eine gewichtige Rolle spielt. 

=== Recht auf Stillpausen
 Ab einer Tages-Arbeitszeit von 4,5 Stunden hat die (stillende) Mutter Anspruch auf 45 Minuten bezahlte Pause für Stillen/Abpumpen. Bei 8 Stunden sind zwei 45 Minuten Pausen vorgesehen, die auch zusammengelegt  werden können. Die Pausen können unter Umständen auch an das Ende des Arbeitstags verlegt werden, sodass die Mutter früher nach Hause geht. Alle Informationen finden sich bei der AK:

#qrbox("https://www.arbeiterkammer.at/stillpause")[Recht auf Stillzeiten
]

=== Eltern-Teilzeit (mit Kündigungsschutz) erst nach Ende der Väterkarenz

Außerdem kann die Mutter noch nicht in die echte Eltern-Teilzeit (falls Anspruch besteht), solange der Vater noch einkommensabhängiges Kinderbetreuungsgeld bezieht. Eine freiwillig vereinbarte Teilzeit mit dem Arbeitgeber ist natürlich möglich.

=== Fremdbetreuung des Kindes nach den 14 Monaten

Euer Kind muss nach den 14 Monaten - es ist dann 1 Jahr und 2 Monate alt - fremdbetreut werden (Kindergarten, Tagesmutter/vater, o.ä.). Ihr beide kehrt ja dann in den Job zurück. \
Ab welchem Alter Kindergärten frühstens eingewöhnen, hängt von eurem Bundesland ab. Vorwarnung: Die Frage, ab wann man in die Fremdbetreung startet, ist teils sehr umstritten - und wird auch sehr emotional diskutiert. Nehmt euch hierfür am besten etwas Zeit.

Ich habe auf karenz-wizard.at versucht, ein paar Links zu sammeln zum Thema. Diese sind aber noch unvollständig:

#qrbox("https://karenz-wizard.at/ab-wann-fremdbetreuung/")[Ab wann soll euer Kind in Fremdbetreuung / Kindergarten gehen?]

=== Ganz allein eure Entscheidung!

Das alles ist aber absolut eure individuelle Entscheidung als Familie und hängt sehr von euren Vorstellungen, eurem Job, möglicher Unterstützung durch Freunde/Großeltern, die Qualität/das Angebot der Kinderbetreuung bei euch vor Ort, etc. ab.

Es gibt hier viele unterschiedliche Wege, wie Eltern das für sich organisieren und entscheiden. Lasst euch nicht judgen!

#pagebreak()

== Unbezahlte Karenzmonate anhängen — Väterkarenz verlängern

_TODO: Einarbeiten/Umschreiben,neu:Rechtsanspruch 2 Jahre, Text von Webseite:_

Das Dranhängen von unbezahlte Karenz-Monaten ist ebenso möglich, um die Karenz als Vater über die 14 Monate eaKBG hinaus zu verlängern.

 Bis zum 2. Lebensjahr des Kindes hast du ja rechtlichen Anspruch auf Karenz, d.h. das Recht auf (unbezahlte) Freistellung beim Arbeitgeber. 

 Somit gehst du bspw. 2 Monate in "bezahlte Karenz" (mit dem eaKBG), und hängst weitere Monate als "unbezahlte Karenz" an.


// Den Lebensunterhalt müsst ihr in diesen unbezahlten Karenz-Monaten aus Ersparnissen und/oder über das Einkommen des anderen Elternteils finanzieren.
#finanzbox("Leben vom Gehalt der Partnerin (oder Ersparnissen)")[
  In den unbezahlten Karenz-Monaten gibt es keine Förderung und
  kein Gehalt für dich — die Familie lebt somit vom Gehalt deiner Partnerin bzw. von Ersparnissen.

  Hier kommt natürlich potenziell ein gesellschaftlicher Misstand hinzu. Da Frauen aufgrund des strukturellen Gender Pay Gaps in Österreich oft weniger verdienen, erfordert diese Option eine genaue Kalkulation: Kann das Gehalt deiner Partnerin die Fixkosten der Familie in dieser Zeit wirklich allein decken - oder kriegt ihr es anders finanziell überbrückt? Somit ist dies leider auch ein Modell, das sich oft nur sehr privilegierte Paare leisten können. Insbesondere bei steigenden Lebenshaltungskosten.
]

=== Krankenversichert über die Mitversicherung bei der Partnerin

Krankenversichern könnt ihr euch über die ÖGK Mitversicherung bei eurer (erwerbstätigen) Partnerin in dieser Zeit. Da du dich der Kindererziehung widmest, fallen hierfür in der Regel auch keinerlei Beitragskosten für dich an. 

Dies aber bitte vorher unbedingt zur Sicherheit bei der ÖGK abklären, die Regelungen sind bspw. unterschiedlich bei verheirateten sowie unverheirateten Paaren.

/*
- TODO: Unbezahlte Karenz-Monate nach den 14 eaKBG-Monaten dranhängen;
  Recht auf (unbezahlte) Freistellung besteht bis zum 2. Lebensjahr.
- TODO: Lebensunterhalt in dieser Zeit aus Ersparnissen und/oder
  Einkommen des anderen Elternteils.
- TODO: Krankenversicherung über ÖGK-Mitversicherung bei der Partnerin;
  bei Kindererziehung meist beitragsfrei — vorher bei der ÖGK abklären
  (Regelungen unterschiedlich bei verheiratet / unverheiratet).
*/ 

=== Leider noch kein Video zum Thema

Leider gibt es zu diesem Thema noch kein gutes Erklärvideo o.ä. . Erstaunlicherweise finden sich generell super wenig Informationen hierzu im Netz. Ich habe versucht, die Informationen hier zusammenzutragen:

#qrbox("https://karenz-wizard.at/unbezahlte-karenz/")[Unbezahlte Karenz & ÖGK Mitversicherung]

#pagebreak()

== Bezahlter (oder unbezahlter) Urlaub — Väterkarenz verlängern

_TODO: Einarbeiten, für Ratgeber nochmal knackiger formulieren_

Eine weitere Möglichkeit, um die Väterkarenz zu verlängern: Du sammelst vorher Urlaubstage und verbrauchst diese dann, um bspw. nach den 14 Monaten eaKBG noch länger daheim zu bleiben. Der Vorteil: Du erhältst 100 % Gehalt statt einer Förderung. Der Nachteil: Dein Urlaubsanspruch ist begrenzt und der Zeitpunkt muss mit dem Arbeitgeber natürlich vereinbart werden, es gibt keinen Rechtsanspruch hierfür.

Ebenso habe ich von der Option gelesen, die Karenz durch unbezahlten Urlaub zu verlängern über die 2 Jahre Recht auf Karenz hinaus - falls der Arbeitgeber dies erlaubt.

/*
- TODO: Urlaubstage vorher ansammeln und nach den 14 eaKBG-Monaten
  verbrauchen → 100 % Gehalt statt Förderung.
- TODO: Nachteil — Urlaubsanspruch begrenzt, kein Rechtsanspruch auf den
  Zeitpunkt, mit dem Arbeitgeber zu vereinbaren.
- TODO: Variante unbezahlter Urlaub zur Verlängerung über die 2 Jahre
  Recht auf Karenz hinaus (falls der Arbeitgeber zustimmt).
*/

#finanzbox("Bezahlter vs. unbezahlter Urlaub")[
  TODO: Bei bezahltem Urlaub volles Gehalt; bei *unbezahltem* Urlaub
  lebt die Familie von einem Gehalt. ]

Mehr Informationen:

#qrbox("https://karenz-wizard.at/urlaub-karenz-verlaengern/")[
  Väterkarenz durch Urlaub verlängern
]

#pagebreak()

== Stunden (freiwillig) reduzieren, bspw. während Mutter in Karenz ist

Niemand verbietet dir, bei deinem Arbeitgeber eine freiwillige  Stundenreduzierung anzufragen. Beispielsweise im ersten Jahr, während deine Partnerin in Karenz ist. 

Von 40h/38,5h Vollzeit auf 35h/Woche oder 32h/Woche temporär reduzieren kann schon einen riesigen Unterschied machen, weil du viel früher daheim bist und mehr Zeit hast, gleichberechtigt Verantwortung zu übernehmen.

_Vorschlag: Nutze die gewonnenen Stunden nicht als ‚Assistent‘ deiner Partnerin, sondern übernehme in dieser Zeit die alleinige Verantwortung für das Kind (inklusive des gesamten Mental Loads wie Tasche packen, Fütterungszeiten im Kopf haben etc.), damit deine Partnerin echte Freizeit hat._

Finanziell verzichtest du natürlich auf einen Teil deines Lohnes:

#qrbox("https://www.finanz.at/arbeitnehmer/teilzeitarbeit/")[Beispiel: Teilzeit-Gehaltssrechner auf finanz.at]

Es gibt natürlich auch etwas zu beachten bei diesem Schritt:

#warnboxgelb("Arbeitgeber muss Stunden später nicht wieder erhöhen")[
  Aufpassen musst du natürlich, weil dein Arbeitgeber deine Arbeitsstunden später ggf. nicht wieder erhöhen muss. In der Regel unterzeichnest du bei Reduktion ja einen neuen Arbeitsvertrag. Falls dir das zu riskant ist, schau dir die kündigungsgeschützte Eltern-Teilzeit im nächsten Kapitel an. Diese geht allerdings erst, wenn beide Elternteile kein Kinderbetreuungsgeld mehr beziehen.
]

#fristbox("Vorher bei AK oder Betriebsrat beraten lassen")[
Informiere dich bei deinem Betriebsrat oder der Arbeiterkammer bei Unsicherheiten, insbesondere bevor du einen neuen Vertrag unterschreibst.
]

#qrbox("https://www.arbeiterkammer.at/beratung/arbeitundrecht/Arbeitszeit/SonderformenderArbeitszeit/Teilzeitarbeit.html")[
  Teilzeitarbeit - Arbeiterkammer
]





#pagebreak()

== Eltern-Teilzeit — das 20h/20h-Modell nach der Karenz

_TODO: Einarbeiten (Kündigungsschutz, nicht jeder hat Anspruch, etc.), Webseiten-Text:_

Gleichberechtigte Partnerschaft und Equal Care kann man auch so gestalten, dass beide Elternteile nach den 14 Monaten eaKBG wieder in den Job einsteigen — aber einer oder beide mit reduzierter Stundenanzahl. Im 20h/20h-Modell wechselt ihr euch beispielsweise so ab: Die Mutter arbeitet von 8 bis 12 Uhr, der Vater von 13 bis 17 Uhr. Mit Anspruch auf Eltern-Teilzeit hast du sogar mehrere Jahre Kündigungs­schutz!

Prüfe deine Voraus­setzungen: Betriebs­größe, Dauer deines Dienst­verhältnisses. Falls du keinen gesetzlichen Anspruch hast, kannst du natürlich auch eine freiwillige Teilzeit mit deinem Arbeitgeber versuchen zu vereinbaren — dann allerdings ohne Kündigungsschutz.

Die Eltern-Teilzeit im 20h/20h-Modell kann eine super Option sein, um das Kind bis zum Kindergarten-Einstieg ab dem 2. Lebensjahr noch gemeinsam zu betreuen und alle Entwicklungsschritte gemeinsam mitzuerleben.


=== 20h/20h-Aufteilung - so lange bis das Kind fremdbetreut wird

Nach Ablauf der 14 Monate einkommensabhängigem Kinderbetreuungsgeld stellt sich oft die Frage, wie es weitergehen soll. Eine Möglichkeit: beide Elternteile reduzieren ihre Arbeitszeit auf ca. 20 Stunden pro Woche und teilen sich die Betreuung, etwa vormittags vs. nachmittags. Somit muss das Kind noch nicht fremdbetreut werden.

#finanzbox("Leben von zwei Teilzeit-Gehältern")[
  //Eure zwei reduzierte Teilzeit-Gehälter - oder Ersparnisse - müssen die Fixkosten der Familie decken in dieser Zeit decken.
  Diese Option setzt natürlich voraus, dass die beiden Teilzeit-Gehälter oder Ersparnisse die Fixkosten der Familie decken können.
]


=== Eltern-Teilzeit kann auch "Lage der Arbeitszeit" ändern bedeuten

Good to know: Eltern-Teilzeit kann auch "Lage der Arbeitszeiten" ändern heißen, nicht zwangsläufig Reduzieren der Arbeitsstunden um mindestens 20%. Beides geht auch.

=== Alternative zur unbezahlten Karenzverlängerung
Dieses Modell vermeidet eine unbezahlte Karenz und bleibt krankenversicherungsrechtlich unproblematisch. Finanziell lohnt es sich je nach Einkommensverteilung unterschiedlich.

Insbesondere der Kündigungsschutz ist natürlich ein großer Vorteil für den sowieso schon ggf. aufregende Rückkehr in die Arbeitswelt.

=== Erst nutzbar, wenn beide Elternteile nicht mehr in Karenz sind

Wichtig für die Planung: Das Recht auf Eltern-Teilzeit kann erst genutzt werden, wenn das andere Elternteil nicht mehr in Karenz ist bei seinem Arbeitgeber, d.h. einkommensabhängiges Kinderbetreuungsgeld bezieht bspw. (Das Beziehen von Sonderleistung 1 zählt allerdings nicht als "echte" Karenz und ist hiervon - soweit ich weiß - ausgenommen.)

=== Auch ohne Anspruch, kann man Teilzeit bei Arbeitgeber anfragen / vereinbaren
Hinweis: Auch ohne Recht auf Eltern-Teilzeit könnt ihr mit eurem Arbeitgeber natürlich Teilzeit versuchen zu vereinbaren. Ein Kündigungsschutz wie der "echten" Eltern-Teilzeit habt ihr dann nicht.

/*

- TODO: *Hinweis* — Möglichkeit, mehr Verantwortung zu übernehmen
  *ohne* (zusätzliche unbezahlte) Karenz: beide steigen nach dem eaKBG
  wieder ein, nur mit reduzierter Stundenzahl.
- TODO: 20h/20h-Modell — zeitlich abwechseln, z. B. Mutter 8–12 Uhr,
  Vater 13–17 Uhr.
- TODO: Mit gesetzlichem Anspruch auf Eltern-Teilzeit besteht
  mehrjähriger Kündigungsschutz.
- TODO: Voraussetzungen prüfen (Betriebsgröße, Dauer des
  Dienstverhältnisses); sonst freiwillige Teilzeit ohne Kündigungsschutz.
- TODO: Gemeinsame Betreuung bis zum Kindergarten-Einstieg möglich.*/



#qrbox("https://karenz-wizard.at/elternteilzeit-20-20/")[Informationen zu Eltern-Teilzeit und 20h/20h-Modell]

#videoqr("https://www.youtube.com/watch?v=sepdrZagF98")[Elternteilzeit - Familie und Beruf vereinbaren (AK)]


#pagebreak()

== AMS & Karenz — Infos zur „AMS-Karenz”

_TODO: Einarbeiten (Achtung, Sonderleistung I mit eaKBG nicht kombierbar, etc.)_

Du oder deine Partnerin ist gerade arbeitssuchend/arbeitslos? 

Die Job-Suche kann mühsam bzw. belastend sein, aber zumindest kannst du alle Entwicklungsschritte deines Kindes mitverfolgen und gleichberechtigt Verantwortung im Haushalt übernehmen. Des Weiteren kannst du trotzdem in eine Art Karenz gehen mit Sonderleistung 1, falls das andere Elternteil eaKBG-Anspruch hat. Beim Arbeitslosengeld gibt es zudem einen Familienzuschlag und du musst auch nur für mindestens 20h/Woche einen Job suchen. Eine „AMS-Karenz“ kann somit also ebenfalls eine Option sein, Verantwortung zu übernehmen.

=== Ohne Job - trotzdem Anspruch auf Sonderleistung 1, wenn Partner/in Anspruch auf einkommensabhängiges Kinderbetreuungsgeld hat

Falls dein/e Partner/in Anspruch auf einkommens­abhängiges Kinder­betreuungs­geld hat, dann kannst du den Basissatz Sonderleistung 1 beziehen. Damit bekommt man zumindest ca. 1.200 € / Monat und ist krankenversichert.

Während du Sonderleistung 1 bekommst, musst du dich vom AMS Arbeitslosengeld für diese Zeit abmelden. Ein gleichzeitiger Bezug ist nicht möglich.

// TODO: full link as footnote for print? - or qr?
=== Familienzuschlag beim Arbeitslosengeld
Siehe #link("https://www.arbeiterkammer.at/beratung/arbeitundrecht/Arbeitslosigkeit/Arbeitslosengeld.html#heading_Familienzuschlag")[Familienzuschlag beim Arbeitslosengeld] (arbeiterkammer.at).

// TODO: full link as footnote for print - or qr?
=== Reisen ins Ausland - abmelden
Obacht bei Familien-Urlauben/Ausflügen ins Ausland, hier muss man sich für diese Zeit vom Arbeitslosengeld abmelden. Siehe #link("https://www.arbeiterkammer.at/beratung/arbeitundrecht/Arbeitslosigkeit/Arbeitslos_und_Urlaub.html")[Arbeitslos & Urlaub] auf arbeiterkammer.at.

Alles Gute für die Jobsuche!

/*
- TODO: Ist ein Elternteil arbeitssuchend, kann man trotzdem alle
  Entwicklungsschritte miterleben und Verantwortung im Haushalt
  übernehmen.
- TODO: Eine Art „Karenz" mit Sonderleistung 1 ist möglich, falls das
  andere Elternteil eaKBG-Anspruch hat (auch ohne Arbeitsverhältnis).
- TODO: Arbeitslosengeld — es gibt einen Familienzuschlag; Jobsuche nur
  für mindestens 20h/Woche erforderlich.
*/

Mehr Informationen:

#qrbox("https://karenz-wizard.at/arbeitssuchend-karenz/")[
  Arbeitssuchend & "Karenz"?
]

#pagebreak()

// TODO: wirklich relevant?
== Tipp: Gemeinsamen Monat beim eaKBG nutzen

_TODO: Einarbeiten (Warnbox - Gesamtanspruch verkürzt sich zeitlich, nach 13 Monaten Ende von eaKBG)_

In den 14 Monaten einkommensabhängiges Kinderbetreuungsgeld könnt ihr auch einen überlappenden Monat nehmen. In diesem seid ihr dann beide daheim und bezieht beide euren eaKBG-Anteil.

Die Gesamtzeit des eaKBG-Bezugs verkürzt sich dadurch natürlich, sodass schon nach 13 Monaten der Bezug endet. (Geld geht euch dadurch aber natürlich nicht verloren)



// TODO: Add info link
// TODO: Add AK video?

#pagebreak()

== Pflegefreistellung in Anspruch nehmen als Vater

_TODO: Einarbeiten ("Kind ist krank, Mutter übernimmt - das muss natürlich nicht sein")_

#pagebreak()

== Sich zu den "unschönen" Themen informieren

_TODO: Einarbeiten (ungerechte Gesellschaft, historisch gewachsen - Überforderung der Mütter, Diskriminierung im Berufsleben, etc. pp.)_

- Mareike Fallwickl Roman „Die Wut, die bleibt“
- Begriffe:
  - Gender Care Gap / Care Arbeit
  - Gender Pension Gap / "finanzielle Macht"
  - Equal Care / Halbe Halbe
  - Emotional Load
  - Gleichberechtigte Elternschaft
  - Frauenstreik (siehe auch Island)
  - Blick nach Skandinavien (?)
- Elternumfrage: https://www.spoe.at/elternkarenz-ergebnisse/ (2026)
- Einige Medienberichte zu (mangelnder) Väterkarenz: https://karenz-wizard.at/infothek/#artikel-warum-maenner-so-wenig-karenz

#pagebreak()

= Crashkurs Kinderbetreuungsgeld <crashkurs>

#fristbox("Unbedingt beraten lassen, bevor ihr etwas beantragt")[
Damit euch aber kein Geld/Förderung verloren geht, lasst ihr euch am besten vor der Antragsstellung bei der Arbeiterkammer oder ÖGK individuell beraten. Bei den vielen Regeln übersieht man schnell etwas, jede Familiensituation ist individuell.
]

Keine Sorge, eigentlich sind die Regelungen in Österreich  absolut keine Raketenwissenschaft! Auch der Kinderbetreuungsgeld-Antrag hat nur vier Seiten.

In Österreich gibt es *zwei Fördermodelle* zur Auswahl:

- das *einkommensabhängige Kinderbetreuungsgeld (eaKBG) für Erwerbstätige, die 182-Tage-Regel erfüllen*
- und das *pauschale Kinderbetreuungsgeld-Konto*, das allen offen steht

Als Paar muss man sich gemeinsam für eins entscheiden, Mischen ist nicht erlaubt.

#heading(level: 2, outlined: false)[Was lohnt sich mehr?]

*Grobe Faustregel:* Falls ihr Anspruch auf das einkommensabhängige
Kinderbetreuungsgeld habt, bekommt ihr in den meisten Fällen deutlich
mehr Geld raus. Während der Gesamttopf beim pauschalen
Kinderbetreuungsgeld-Konto für beide Elternteile bei ca. 18.760 €
gedeckelt ist (maximal 41,14 € pro Tag), könnt ihr beim eaKBG insgesamt
bis zu ca. 34.130 € an Transferleistungen abholen, da der Höchstsatz
hier bei stolzen 80,12 € pro Tag liegt (abhängig vom Gehalt).

Daher lohnt es sich finanziell oft mehr, die 14 Monate des eaKBG voll
auszuschöpfen und danach bspw. noch einige Monate unbezahlte Karenz
dranzuhängen o.ä. Warum? Weil ihr selbst nach Abzug der Lebenshaltungskosten in den
angehängten, unbezahlten Karenzmonaten unterm Strich eine deutlich
höhere Gesamtsumme zur Verfügung habt als im langgestreckten
Pauschalmodell (bis zu 2 Jahre möglich).

#v(8pt)
#videoqr("https://youtu.be/JdoIhtTYxh8")[Kinderbetreuungsgeld — die zwei Modelle erklärt (AK)]

#videoqr("https://youtu.be/_68qceI3lLU")[Teilung von Karenz & Kinderbetreuungsgeld (AK)]

#heading(level: 2, outlined: false)[Die wichtigsten Unterschiede]

#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  align: left + top,
  stroke: 0.5pt + luma(210),
  fill: (col, row) => if row == 0 { luma(238) },

  // table.header (ab Typst 0.11): Kopfzeile wiederholt sich
  // automatisch bei Seitenumbruch der Tabelle.
  table.header(
    [],
    [*Pauschales KBG (KBG-Konto)*],
    [*Einkommensabhängiges KBG (eaKBG)*],
  ),

  [*Anspruch*],
  [Alle Eltern, unabhängig von vorheriger Erwerbstätigkeit],
  [Nur wenn mind. ein Elternteil vor Geburt/Mutterschutz erwerbstätig
   war (182-Tage-Regel)],

  [*Bezugsdauer\ (beide in Karenz)*],
  [15–35 Monate. Obacht: Recht auf Karenz beim Arbeitgeber nur bis zum
   2. Lebensjahr],
  [Max. 14 Monate ab Geburt; der Vater muss davon mind. 2 Monate
   (61 Tage) in Karenz gehen],

  [*Max. Förderungs\ summe*],
  [Bis zu *18.760 €* gesamt (max. 41,14 €/Tag; Stand 2026)],
  [Bis zu *ca. 34.130 €* (426 Tage × 80,12 €/Tag, ca. 2.400 €/Monat, ca.
   80 % des Gehalts; Stand 2026). Hat nur ein Elternteil Anspruch, erhält
   der andere Sonderleistung I (41,14 €/Tag, ca. 1.200 €/Monat)],

  [*Rechner*],
  [#link("https://services.bundeskanzleramt.gv.at/KBG-Rechner/index.html#kbgKonto")[KBG-Konto-Rechner (bundeskanzleramt.gv.at)]],
  [#link("https://services.bundeskanzleramt.gv.at/KBG-Rechner/index.html#eaKbg")[eaKBG-Rechner (bundeskanzleramt.gv.at)]],
)


// ============================================================
//  VORAUSSETZUNG: 182-TAGE-REGEL
// ============================================================

== Anspruch prüfen: Die 182-Tage-Regel für das eaKBG

// Prüft euren Anspruch und den jeweiligen Stichtag mit dem interaktiven Rechner:

#qrbox("https://karenz-wizard.at/eakbg-anspruch/")[eaKBG-Anspruch & Stichtag prüfen — interaktiver Rechner]

=== Basissatz Sonderleistung 1 beim eaKBG

Sollte nur einer von euch Anspruch haben, kann der / die andere Partner/in den Basissatz Sonderleistung I beziehen (ca. 1.200€/Monat). Selbst wenn er/sie nicht erwerbstätig ist - in dieser Zeit nur Abmelden von AMS nötig.

#qrbox("https://karenz-wizard.at/sonderleistung-1/")[eaKBG: Sonderleistung 1]


// ============================================================
//  ABSCHLUSS
// ============================================================

// TODO move up 
// == TODO: Stunden reduzieren im ersten Jahr  (auskommentiert: gehoert woanders hin)
#pagebreak()

= Weitere Informationen

Auf karenz-wizard.at habe ich auf einer Webseite versucht zusammenzustellen, was ich bei meiner Planung damals ebenso vermisst habe: 

Einen Schritt-für-Schritt Überblick sowie einen interaktiven eaKBG-Planer.

#qrbox("https://karenz-wizard.at/schritte-im-ueberblick/")[Alle Schritte im Überblick — der Karenz Wizard]

#v(8pt)
#qrbox("https://karenz-wizard.at/eakbg-planer/")[Interaktiver eaKBG-Planer — Aufteilung durchspielen]

== Papamonat nach Geburt nehmen, eh klar!

Bevor es an die Karenzplanung und die Zeit danach geht, hast du nach der Geburt großartigerweise in Österreich gesetzlichen Anspruch auf die Papamonat-Freistellung. Genauer gesagt ab der Entlassung deiner Partnerin aus dem Krankenhaus, also sobald ihr im gemeinsamen Haushalt seid. 

Ob du in dieser Zeit die staatliche Förderung (Familienzeitbonus) erhältst, hängt von der 182-Tage-Regel ab. Du kannst aber auch unbezahlt in den Papamonat gehen - den ersten Lebensmonat deines Kindes möchtest du ja sicher daheim miterleben und deine Partnerin unterstützen (falls finanziell möglich).

// TODO: correct?
// Der Papamonat zählt nicht als "echte" Karenz, also hat auch nichts mit den 14 Monaten eaKBG zu tun.

#qrbox("https://karenz-wizard.at/fzb-anspruch/")[Papamonat & Familienzeitbonus-Anspruch prüfen]

// TODO: add AK video box

#pagebreak()


// ============================================================
//  EINORDNUNG (Schluss-Kapitel: Rahmen & Grenzen)
// ============================================================

= Fehlt eine Option? Feedback?

Sehr gerne bei mir melden, kurze Nachricht genügt!

-  E-Mail: #link("mailto:matthias-andrasch-kontakt@mailbox.org")[matthias-andrasch-kontakt\@mailbox.org]
- Instagram: #link("https://www.instagram.com/karenz_wizard/")[\@karenz_wizard]
- Web: #link("https://karenz-wizard.at")[karenz-wizard.at]

Der Karenz Wizard ist ein Gemeinschaftsprojekt für mehr Väterbeteiligung.

== Kritische Einordnung / Disclaimer

- Dieser Ratgeber zeigt nur *Möglichkeiten im bestehenden Sozialsystem
  Österreichs* auf. Politische und systemische Veränderungen sind das
  andere, ebenso wichtige Thema, wofür es sich einzusetzen lohnt. Hier gibt es noch viel zu tun!
- *Eine Frage der (finanziellen) Möglichkeiten*: Karenzplanung ist auch
  eine Frage der finanziellen Ressourcen — *einige Optionen stehen nur
  privilegierten Personen (mit finanziellem Puffer) zur Verfügung*.
  Insbesondere bei steigenden Miet- und Lebenshaltungskosten verschärft
  sich diese Ungleichheit potenziell noch mehr.
- Nicht zuletzt *berichten auch einige Väter von Diskriminierungen im Job, wenn sie ihre Elternzeit in Anspruch nehmen möchten*. Es hängt also von vielen Faktoren ab.
- *Warum hörte man bisher so wenig von der 14-Monate-Herausforderung?* Bisher behalfen sich Familien auch oft mit der Bildungskarenz im zweiten Jahr. Das erste Jahr war gefördert mit einkommensabhängigem Kinderbetreuungsgeld - das zweite Jahr durch Bildungskarenz, bei welcher ein Elternteil sich zuhause in einem Online-Kurs weiterqualifizierte und das Kind betreute. Eine "Brücke zurück ins Erwerbsleben". Seit Anfang 2026 ist dies nicht mehr erlaubt: *Bildungskarenz nach der Elternzeit nicht mehr erlaubt* (#link("https://karenz-wizard.at/blog/bildungskarenz-bruecke-erwerbsleben-entfaellt/")[karenz-wizard.at/blog/bildungskarenz-bruecke-erwerbsleben-entfaellt/]). Für jetzige Eltern fällt also eine bezahlte Option komplett weg.
- Der Ratgeber *leider noch nicht bzgl. Regenbogenfamilien optimiert*. Ich bitte dies zu entschuldigen! (Falls jemand hierzu unterstützen kann, ob rechtlich alles gleichgestellt ist - gerne melden!)

