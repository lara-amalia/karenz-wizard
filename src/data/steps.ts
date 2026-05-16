// Centralized step metadata used by:
// - /schritte-im-ueberblick/ (overview cards)
// - all linked step subpages (page H1, teaser paragraph, prev/next nav)
//
// Edit titles/teasers here once and they propagate everywhere.

export type StepEmbed = {
  provider: 'youtube' | 'twitter' | 'mastodon' | 'vimeo' | 'other';
  embedUrl: string;
  title: string;
  directUrl: string;
};

export type StepLink = {
  title: string; // e.g. "Kinderbetreuungsgeld"
  url: string; // e.g. "https://www.arbeiterkammer.at/kbg"
  source: string; // e.g. "arbeiterkammer.at"
};

export type StepCard = {
  kicker?: string; // small uppercase label above the card title
  kickerMobile?: string; // shorter kicker shown on mobile (<640px); falls back to `kicker`
  ctaLabel?: string; // text on the card's primary CTA button
  ctaLink?: string; // override URL for the CTA button. Defaults to
  // `${step.href}#inhalt` (jumps past the teaser on the subpage).
  variant?: 'primary' | 'sub'; // 'sub' = indented sub-step (5.1, 5.2, ...)
  openInNewTab?: boolean; // open the CTA link in a new browser tab
};

export type StepMoreInformation = {
  embed?: StepEmbed[]; // one or more videos. The first is shown on the
  // overview card; the full list is rendered on the subpage under
  // "Videos zum Thema:".
  links?: StepLink[]; // external link list rendered above NextStep on the
  // subpage under "Offizielle Informationsquellen:".
};

export type Step = {
  number: string; // "1", "2", "3", "5.1", "5.2", "5.3", "5.4", "4" ... "9"
  title: string; // may contain HTML entities like &shy;
  href: string;
  teaser: string | string[]; // shown as card description AND as the first
  // paragraph(s) on the subpage. Use an array for multi-paragraph teasers;
  // a plain string is treated as a single paragraph.
  oldTexts?: string[]; // legacy paragraphs from the old card description, shown
  // in dev-only "TODO: integrate" box on the subpage
  stepCards?: StepCard; // overview-card metadata (kicker, CTA label, variant)
  moreInformation?: StepMoreInformation; // video + link list shown at the bottom of the subpage
};

export const steps: Step[] = [
  {
    number: '1',
    title: '1. Registriert euch beim AK Elternkalender',
    href: '/ak-elternkalender/',
    stepCards: {
      kicker: 'Schritt 1: Keine Frist verpassen',
      kickerMobile: 'Schritt 1',
      ctaLabel: 'Jetzt beim Elternkalender registrieren',
    },
    teaser: [
      'Willkommen in deinem neuen Abenteuer! In Zukunft wird es einige Fristen geben, die ihr beachten müsst. Damit euch keine durchrutscht, hilft der Elternkalender der Arbeiterkammer.',
      'Der Elternkalender zeigt wichtige Fristen (Papamonat Vorankündigung, Mutter-Kind-Pass, KBG-Antrag, Meldungen beim Arbeitgeber, etc) und verschickt zudem auch Benachrichtigungen. Die Registrierung dauert nur wenige Minuten und ist kostenfrei. Am besten noch heute erledigen:',
    ],
  },
  {
    number: '2',
    title: '2. Gibt es in nächster Zeit Info-Veranstaltungen?',
    href: '/info-veranstaltungen/',
    stepCards: {
      kicker: 'Schritt 2: Informiert euch zu Terminen',
      kickerMobile: 'Schritt 2',
      ctaLabel: 'Mehr zu Info-Veranstaltungen ',
    },
    teaser: [
      'Die Arbeiterkammer in deinem Bundesland bietet in der Regel Informations­veranstaltungen oder auch Webinare an, bei denen die Grundlagen erklärt werden.',
      'Falls ihr keine Infos zu Veranstaltungen findet, fragt am besten einfach kurz bei eurer AK nach!',
      'Auch Initiativen wie der Verein Papainfo bieten Webinare an.',
    ],
  },
  {
    number: '3',
    title: '3. Der erste (Papa-)Monat steht dir immer zu! 🥳',
    href: '/fzb-anspruch/',
    stepCards: {
      kicker: 'Schritt 3: Familienzeitbonus-Anspruch prüfen für Papamonat',
      kickerMobile: 'Schritt 3: FZB-Anspruch',
      ctaLabel: 'Mehr Infos & Familienzeitbonus-Anspruch prüfen',
    },
    teaser: [
      'Die erste gute Nachricht: Du hast in Österreich - tollerweise! - das gesetzliche Recht auf Freistellung im ersten Lebensmonat deines Kindes. So kannst du den ersten Monat daheim miterleben und deine Partnerin im Wochenbett voll unterstützen. 💪',
      'Das Recht auf einen Monat Freistellung nach der Geburt steht dir immer zu, dein Arbeitgeber muss dich jedoch nur unbezahlt freistellen.',
      'Es gibt jedoch hierfür eine staatliche Förderung für diesen Monat, den Familienzeitbonus. Dieser ist an die 182-Tage-Regel (= ca. 6 Monate durchgehende Arbeit vor Geburt) gekoppelt. Berechne auf dieser Seite deinen 182-Tage-Zeitraum vor der Geburt und prüfe, ob du durchgehend gearbeitet und kein AMS-/Notstands-/Weiter­bildungsgeld bezogen hast. Erfüllst du die Vorraussetzungen, bekommst du im Papamonat den Familienzeitbonus vom Staat gezahlt.',
      'Erfüllst du die Vorraussetzungen nicht, kannst du den Papamonat dennoch nehmen - finanzieren musst du dich in diesem Monat allerdings dann natürlich selber.',
      'Wichtig: Beachte die Frist, wann du den Papamonat spätestens vorankündigen musst.',
      'Tipp: Der Papamonat gilt erst ab Entlassung von Mutter und Kind aus Krankenhaus, heb dir also ein paar Urlaubstage auf für die Krankenhaus-Zeit auf.',
    ],
    moreInformation: {
      embed: [
        {
          provider: 'youtube',
          embedUrl: 'https://www.youtube-nocookie.com/embed/IMUBAZGAER8',
          title: 'Papamonat in Österreich | Meldung, Antrag & Geld (AK/YouTube)',
          directUrl: 'https://www.youtube.com/watch?v=IMUBAZGAER8',
        },
      ],
      links: [
        {
          title: 'Papamonat und Familienzeitbonus',
          url: 'https://www.arbeiterkammer.at/papamonat',
          source: 'arbeiterkammer.at',
        },
      ],
    },
    oldTexts: [
      'Die gute Nachricht: Du hast in Österreich das Recht auf Freistellung im ersten Monat nach der Geburt. So kannst du den ersten Monat daheim miterleben und im Wochenbett voll unterstützen.',
      'Die "schlechte" Nachricht: Anspruch auf die staatliche Förderung für den Papamonat, den Familienzeitbonus, hast du allerdings nicht automatisch. Die Förderung ist an die 182-Tage-Regel geknüpft (= ca. 6 Monat durchgehende Arbeit vor Geburt / kein AMS-Bezug o.ä. in dieser Zeit).',
      'Wichtig: Das Recht auf Freistellung bei deinem Arbeitgeber hast du immer - den Monat musst du halt selber finanzieren, falls du keinen Anspruch auf staatliche Förderung (Familienzeitbonus) hast.',
      'Tipp: Die Papamonat-Freistellung gilt erst ab Entlassung von Mutter und Kind aus dem Krankenhaus, heb dir also ein paar Urlaubstage für die Krankenhauszeit auf.',
    ],
  },
  {
    number: '4',
    title:
      '4. Hat mindestens einer von euch Anspruch auf einkommens&shy;abhängiges Kinderbetreuung&shy;sgeld?',
    href: '/eakbg-anspruch/',
    stepCards: {
      kicker: 'Schritt 4: eaKBG-Anspruch prüfen (182-Tage-Regel)',
      kickerMobile: 'Schritt 4',
      ctaLabel: 'eaKBG-Anspruch jetzt prüfen',
    },
    teaser: [
      'Finde zuerst heraus, ob mindestens einer von euch Anspruch auf einkommens&shy;abhängiges Kinder&shy;betreuungs&shy;geld (eaKBG) hat — davon hängt die weitere Planung ab. Beim eaKBG erhaltet ihr in der Regel deutlich mehr Förderung als beim pauschalen Kinderbetreuungsgeld - das eaKBG ist jedoch auf 14 Monate (ab Geburt) begrenzt. Es lohnt sich in der Regel aber trotzdem finanziell, selbst wenn der Vater noch einige Monate unbezahlt in Karenz dranhängt.',
      'Prüft für euch die 182-Tage-Regel: 6 Monate durchgehend erwerbstätig, kein AMS-, Notstands-, Weiter&shy;bildungsgeld. Obacht, der Stichtag für die 182 Tage sind für Mutter und Vater unterschiedlich! Berechnet den Stichtag hier auf dieser Seite im interaktiven Tool.',
      'Falls nur einer von euch Anspruch auf eaKBG hat, bekommt der andere den Bassisatz Sonderleistung 1 (~1.200 €/Monat) für seine Karenzmonate. Dies ist ebenso ohne aktuelles Arbeitsverhältnis möglich.',
      'Hat keiner von euch Anspruch, dann könnt ihr nur das pauschale Kinderbetreuungsgeld-Konto nutzen. Dieses ist nicht auf 14 Monate begrenzt wie das eaKBG, aber die Fördersumme ist deutlich niedriger. Prüft euren Anspruch:',
    ],
    moreInformation: {
      embed: [
        {
          provider: 'youtube',
          embedUrl: 'https://www.youtube-nocookie.com/embed/JdoIhtTYxh8',
          title: 'Kinderbetreuungsgeld in Österreich | Zwei Modelle erklärt (AK)',
          directUrl: 'https://www.youtube.com/watch?v=JdoIhtTYxh8',
        },
      ],
      links: [
        {
          url: 'https://www.arbeiterkammer.at/kbg#heading_Einkommensabhaengiges_Kinderbetreuungsgeld',
          title: 'Einkommensabhängiges Kinderbetreuungsgeld',
          source: 'arbeiterkammer.at',
        },
      ],
    },
    oldTexts: [
      'Bevor ihr in die Detailplanung geht, müsst ihr klären ob mindestens ein Elternteil eaKBG-Anspruch hat. In Österreich gibt es zwei Fördermodelle:',
      'Zum einen das einkommens&shy;abhängige Kinderbetreuungs&shy;geld (eaKBG) - aber nur wenn man vorher 182 Tage (ca. 6 Monate) durchgehend gearbeitet hat. Es beträgt ca. 80% des letzten Gehalts, maximal 14 Monate lang ab Geburt (wenn der Vater mindestens 2 Monate in Karenz geht).',
      'Und zum anderen gibt es das pauschale Kinderbetreuungsgeld-Konto, offen für alle.',
      'Als Paar könnt ihr nur eins der Modelle nutzen.',
      'Grobe Faustregel: Wenn ihr eaKBG-Anspruch habt, dann bekommt ihr in den meisten Fällen mehr Geld bei diesem Fördermodell raus - im Gegensatz zum pauschalen KBG-Konto. Am Ende kommt es aber auf eure individuelle Situation (und euer Gehalt) an, was sich mehr lohnt. Lasst euch hier unbedingt kostenfrei bei AK oder ÖGK beraten!',
      'Die wichtigste Frage ist also zuerst: Hat mindestens einer von euch Anspruch auf das einkommens&shy;abhängige Kinderbetreuungsgeld (eaKBG)?',
      'Hierfür muss die 182-Tage-Regel geprüft werden, d.h. ob ca. 6 Monate durchgehend gearbeitet wurde, kein Arbeitslosengeld bezogen wurde, etc.',
      "Hat nur ein Elternteil Anspruch, bekommt der andere in seiner Karenzzeit den Basissatz Sonder&shy;leistung 1. Dieser beträgt aktuell ca. 1'200€ / Monat.",
      'Falls gar keiner von euch Anspruch hat, bleibt nur das pauschale Kinderbetreuungs&shy;geld-Konto.',
      'Hier erfahren, wie man den Anspruch prüft und welcher Stichtag für die 182-Tage-Regel gilt:',
    ],
  },
  {
    number: '5',
    title:
      '5. Wie wollt ihr die Karenzmonate aufteilen? Könnt ihr mehr als zwei Monate Väterkarenz ermöglichen?',
    href: '/eakbg-planer/',
    stepCards: {
      kicker: 'Schritt 5: Die Zeit und Aufteilung',
      kickerMobile: 'Schritt 5',
      ctaLabel: 'Eure eaKBG-Karenz interaktiv planen',
    },
    teaser: [
      'Falls mindestens einer von euch eaKBG-Anspruch hat: Starte hier mit den minimalen zwei Monaten Väterkarenz beim einkommens&shy;abhängigen Kinderbetreuungs&shy;geld im interaktiven Planer. Schau dir Möglichkeiten für eine längere Väterkarenz an:',
      'Entweder indem die Mutter weniger Monate nimmt im ersten Teil - oder indem du als Vater noch in unbezahlte Karenz (5.1) gehst nach den maximalen 14 Monaten eaKBG-Förderung. Ein gesetzliches Recht auf (unbezahlte) Karenz-Freistellung hast du nämlich bis zum 2. Lebensjahr. Eine Eltern-Teilzeit (5.2) im Anschluss könnte ebenso eine Option sein, um gleichberechtigt Verantwortung zu übernehmen -  falls du gesetzlichen Anspruch bei deinem Arbeitgeber hast, sogar mit Kündigungsschutz. Tipp: Beim eaKBG ist ein gemeinsamer Monat möglich, siehe Checkbox. Nutze den interaktiven Planer:',
    ],

    moreInformation: {
      embed: [
        {
          provider: 'youtube',
          embedUrl: 'https://www.youtube-nocookie.com/embed/_68qceI3lLU',
          title: 'Teilung Karenz und Kinderbetreuungsgeld in Österreich (AK)',
          directUrl: 'https://www.youtube.com/watch?v=_68qceI3lLU',
        },
      ],
      links: [
        {
          title: 'Teilung der Karenz',
          source: 'arbeiterkammer.at',
          url: 'https://www.arbeiterkammer.at/beratung/berufundfamilie/Karenz/Teilung_der_Karenz.html',
        },
      ],
    },
    oldTexts: [
      'Staatliche Förderung und Recht auf Karenz sind zwei verschiedene Paar Schuhe.',
      'In Österreich habt ihr gegenüber eurem Arbeitgeber Anspruch auf zwei Jahre Karenz-Freistellung, jedoch nicht auf Bezahlung.',
      'Das gute einkommens&shy;abhängiges Kinderbetreuungs&shy;geld, welches ca. 80% vom Einkommen beträgt, wird nur maximal 14 Monate lang vom Staat an euch ausgezahlt. Die 14 Monate gelten ab Geburt. Bedingung für die vollen 14 Monate ist, dass der Vater mindestens 2 Monate Karenz nimmt.',
      'Wie ihr die 14 Monate aufteilt, könnt ihr relativ flexibel selber entscheiden.',
      'Ihr könnt auch einen Monat gemeinsam eaKBG beziehen und in dieser Zeit gemeinsam daheim sein (oder reisen). Einige Vorgaben gibt es natürlich dennoch zu beachten (siehe AK-Video).',
      'Natürlich stellt sich hier schnell eine schwierige Frage: Möchte die Mutter beispielsweise 12 Monate in Karenz gehen, dann wird es für den Vater knapp. Staatliche Förderung gibt es nur mehr für 2 Monate. Die gute Nachricht: Das Recht auf Karenz-Frei&shy;stellung beim Arbeitgeber hast du bis zum 2. Geburtstag des Kindes. Du kannst also deutlich länger in Karenz gehen! (falls finanziell leistbar)',
      'Welche Optionen es nach den 14 Monaten gibt, seht ihr in den Schritten weiter unten. Beispielsweise das Verlängern der Väterkarenz mit einer "unbezahlten Karenz" - oder das Nutzen der Eltern-Teilzeit im 20h/20h-Modell. Bei diesem wechselt ihr euch beispielsweise mittags ab: Die Mutter arbeitet von 8 bis 12 Uhr, der Vater von 13 bis 17 Uhr. Bei beiden Alternativen müsst ihr natürlich mit einem Gehalt auskommen bzw. über Ersparnisse verfügen.',
      'Nutzt den interaktiven eaKBG-Planer, um verschiedene Aufteilungsmodelle auszuprobieren:',
    ],
  },
  {
    number: '5.1',
    title: '5.1 Unbezahlte Karenz: Länger in Karenz sein als Vater',
    href: '/unbezahlte-karenz/',
    stepCards: {
      kicker: 'Option: Unbezahlte Karenzmonate anhängen',
      kickerMobile: 'Option: Unbezahlte Karenz',
      ctaLabel: 'Alles zur unbezahlten Karenz',
      variant: 'sub',
    },
    teaser: [
      'Das Dranhängen von unbezahlte Karenz-Monaten ist ebenso möglich, um die Karenz als Vater über die 14 Monate eaKBG hinaus zu verlängern. Bis zum 2. Lebensjahr des Kindes hast du ja rechtlichen Anspruch auf Karenz, d.h. das Recht auf (unbezahlte) Freistellung beim Arbeitgeber. Den Lebensunterhalt müsst ihr in diesen unbezahlten Karenz-Monaten aus Ersparnissen und/oder über das Einkommen des anderen Elternteils finanzieren.',
      'Krankenversichern könnt ihr euch über die ÖGK Mitversicherung bei eurer Partnerin in dieser Zeit. Da du dich der Kindererziehung widmest, fallen hierfür in der Regel auch keinerlei Beitragskosten für dich an. Dies aber bitte vorher unbedingt bei der ÖGK abklären, die Regelungen sind unterschiedlich bei verheirateten sowie unverheirateten Paaren.',
    ],
  },
  {
    number: '5.2',
    title: '5.2 Das 20h/20h-Modell: Gemeinsam anpacken mit Eltern-Teilzeit!',
    href: '/elternteilzeit-20-20/',
    stepCards: {
      kicker: 'Option: Eltern-Teilzeit',
      ctaLabel: 'Mehr über Eltern-Teilzeit erfahren',
      variant: 'sub',
    },
    teaser: [
      'Gleichberechtigte Partnerschaft und Equal Care kann man auch so gestalten, dass beide Elternteile nach den 14 Monaten eaKBG wieder in den Job einsteigen — aber einer oder beide mit reduzierter Stundenanzahl. Im 20h/20h-Modell wechselt ihr euch beispielsweise so ab: Die Mutter arbeitet von 8 bis 12 Uhr, der Vater von 13 bis 17 Uhr. Mit Anspruch auf Eltern-Teilzeit hast du sogar mehrere Jahre Kündigungs&shy;schutz!',
      'Prüfe deine Voraus&shy;setzungen: Betriebs&shy;größe, Dauer deines Dienst&shy;verhältnisses. Falls du keinen gesetzlichen Anspruch hast, kannst du natürlich auch eine freiwillige Teilzeit mit deinem Arbeitgeber versuchen zu vereinbaren — dann allerdings ohne Kündigungsschutz.',
      'Die Eltern-Teilzeit im 20h/20h-Modell kann eine super Option sein, um das Kind bis zum Kindergarten-Einstieg ab dem 2. Lebensjahr noch gemeinsam zu betreuen und alle Entwicklungsschritte gemeinsam mitzuerleben.',
      'Diese Option setzt natürlich voraus, dass die beiden Teilzeit-Gehälter oder Ersparnisse die Fixkosten der Familie decken können.',
    ],
    moreInformation: {
      embed: [
        {
          provider: 'youtube',
          embedUrl: 'https://www.youtube-nocookie.com/embed/sepdrZagF98',
          title: 'Elternteilzeit in Österreich (AK/YouTube)',
          directUrl: 'https://www.youtube.com/watch?v=sepdrZagF98',
        },
      ],
      links: [
        {
          title: 'Elternteilzeit',
          url: 'https://arbeiterkammer.at/elternteilzeit',
          source: 'arbeiterkammer.at',
        },
      ],
    },
  },
  {
    number: '5.3',
    title: '5.3 Väterkarenz durch Urlaub verlängern',
    href: '/urlaub-karenz-verlaengern/',
    stepCards: {
      kicker: 'Option: Bezahlter (oder unbezahlter) Urlaub',
      kickerMobile: 'Option: Urlaub',
      ctaLabel: 'Mehr Informationen',
      variant: 'sub',
    },
    teaser: [
      'Eine weitere Möglichkeit, um die Väterkarenz zu verlängern: Du sammelst vorher Urlaubstage und verbrauchst diese dann, um bspw. nach den 14 Monaten eaKBG noch länger daheim zu bleiben. Der Vorteil: Du erhältst 100 % Gehalt statt einer Förderung. Der Nachteil: Dein Urlaubsanspruch ist begrenzt und der Zeitpunkt muss mit dem Arbeitgeber natürlich vereinbart werden, es gibt keinen Rechtsanspruch hierfür.',
      'Ebenso habe ich von der Option gelesen, die Karenz durch unbezahlten Urlaub zu verlängern über die 2 Jahre Recht auf Karenz hinaus - falls der Arbeitgeber dies erlaubt.',
    ],
    moreInformation: {
      links: [
        {
          title: 'Wird durch Karenz Ihr Urlaub verkürzt?',
          url: 'https://www.arbeiterkammer.at/beratung/berufundfamilie/Karenz/Karenz-Regelung.html#heading_Wird_durch_Karenz_Ihr_Urlaub_verkuerzt_',
          source: 'arbeiterkammer.at',
        },
        {
          title: 'Karenzverlängerung durch unbezahlten Urlaub',
          url: 'https://finanzundrecht.at/familie/karenzverlaengerung-durch-unbezahlten-urlaub/',
          source: 'finanzundrecht.at',
        },
      ],
    },
  },
  {
    number: '5.4',
    title: '5.4 Arbeitssuchend & "Karenz"?',
    href: '/arbeitssuchend-karenz/',
    stepCards: {
      kicker: 'Infos zur "AMS-Karenz"',
      ctaLabel: 'Mehr zu Arbeitssuchend & "Karenz"',
      variant: 'sub',
    },
    teaser: [
      'Du oder deine Partnerin ist gerade arbeitssuchend/arbeitslos? Die Job-Suche kann mühsam bzw. belastend sein, aber zumindest kannst du alle Entwicklungsschritte deines Kindes mitverfolgen und gleichberechtigt Verantwortung im Haushalt übernehmen. Des Weiteren kannst du trotzdem in eine Art Karenz gehen mit Sonderleistung 1, falls das andere Elternteil eaKBG-Anspruch hat. Beim Arbeitslosengeld gibt es zudem einen Familienzuschlag und du musst auch nur für mindestens 20h/Woche einen Job suchen. Eine „AMS-Karenz“ kann somit also ebenfalls eine Option sein, Verantwortung zu übernehmen.',
    ],
  },
  {
    number: '6',
    title: '6. Ab wann soll euer Kind in Fremdbetreuung / Kindergarten gehen?',
    href: '/ab-wann-fremdbetreuung/',
    stepCards: {
      kicker: 'Schritt 6: Die (eigentlich) große Entscheidung',
      kickerMobile: 'Schritt 6',
      ctaLabel: 'Mehr zur Frage der Fremdbetreuung',
    },
    teaser: [
      'Sprich mit deiner Partnerin in Ruhe darüber, ab wann euer Kind in den Kindergarten oder bei einer Tages&shy;mutter/Tages&shy;vater betreut werden soll — davon hängt eure ganze Planung ab. Also auch ab wann ihr auch wieder wie viel arbeiten wollt, wie Wiedereinstieg in Beruf und Eingewöhnung in Kindergarten ablaufen sollen, ob (Eltern-)Teilzeit eine Rolle spielt, etc. pp.',
      'Die Regeln für Kindergarten sind in jedem Bundes&shy;land anders: Aufnahme&shy;alter, Anmelde&shy;fristen und Saisonstart variieren. In Wien beginnt das Kindergarten&shy;jahr z.B. regulär im Herbst.',
      'Die Frage der Fremdbetreuung kann auch durchaus sehr emotional sein - nehmt euch hierfür also am besten genügend Zeit, auch um andere Eltern nach ihren Erfahrungen zu fragen, Artikel zu lesen, etc.',
      'Ich habe ein paar Links gesammelt, die Entscheidung trefft ihr jedoch ganz allein - und jedes Kind ist anders und entwickelt sich individuell:',
    ],
  },
  {
    number: '7',
    title: '7. Eure Planung überprüfen lassen und den Kinderbetreuungsgeld-Antrag stellen',
    href: '/planung-ueberpruefen-und-antrag-stellen/',
    stepCards: {
      kicker: 'Schritt 7: Beratung nutzen & Antrag',
      kickerMobile: 'Schritt 7',
      ctaLabel: 'Beratung & Antrag stellen',
    },
    teaser: [
      'Ihr habt einen Plan für euch? Super! Damit euch aber kein Geld/Förderung verloren geht, lasst ihr euch am besten vor der Antragsstellung bei der Arbeiterkammer oder ÖGK individuell beraten. Bei den vielen Regeln übersieht man schnell etwas, jede Familiensituation ist individuell. Die gute Nachricht: Der Antrag hat in Österreich nur vier Seiten und ist schnell erledigt. Schau ihn dir am besten als PDF an, Unklarheiten beim Ausfüllen kannst du dann in der Beratung direkt klären.',
    ],
  },
  {
    number: '8',
    title: '8. Anspruch auf Partnerschaftsbonus',
    href: '/partnerschaftsbonus/',
    stepCards: {
      kicker: 'Schritt 8: Kinderbetreuungsgeld 50:50 oder 60:40 aufgeteilt?',
      kickerMobile: 'Schritt 8',
      ctaLabel: 'Mehr erfahren',
    },
    teaser: [
      '„Haben die Eltern das Kinderbetreuungsgeld zu annähernd gleichen Teilen (50:50 bis 60:40) und mindestens im Ausmaß von je 124 Tagen rechtmäßig und tatsächlich bezogen, so gebührt jedem Elternteil auf Antrag nach Ablauf der höchstmöglichen Gesamtanspruchs&shy;dauer ein Partnerschaftsbonus." (Quelle: ÖGK, April 2026).',
      'Aktuell beträgt der Bonus 500€ pro Person (einmalige Auszahlung)',
    ],
    moreInformation: {
      links: [
        {
          title: 'Partnerschaftsbonus - Infos und Antrag',
          url: 'https://www.oegk.at/cdscontent/?contentid=10007.879642&portal=oegkportal',
          source: 'oegk.at',
        },
        {
          title: 'Partnerschaftsbonus',
          url: 'https://www.oesterreich.gv.at/de/themen/familie_und_partnerschaft/finanzielle-unterstuetzungen/3/2/Seite.080631',
          source: 'oesterreich.gv.at',
        },
      ],
    },
  },
  {
    number: '9',
    title: '9. Pensionssplitting',
    href: '/pensionssplitting/',
    stepCards: {
      kicker: 'Schritt 9',
      ctaLabel: 'Mehr über Pensionssplitting',
    },
    teaser: 'Sprich mit deiner Partnerin über die freiwillige Option des Pensions&shy;splitting.',
    moreInformation: {
      links: [
        {
          title: 'Was ist Pensionssplitting? (Beitrag: Kindererziehungszeiten)',
          url: 'https://www.arbeiterkammer.at/beratung/arbeitundrecht/pension/pensionshoehe/Kindererziehungszeiten.html#heading_Was_ist_Pensionssplitting_',
          source: 'arbeiterkammer.at',
        },
        {
          title: 'Pensionssplitting',
          url: 'https://stmk.arbeiterkammer.at/beratung/arbeitundrecht/pension/Pensionssplitting.html',
          source: 'stmk.arbeiterkammer.at',
        },
      ],
      // TODO: add shorts video? https://www.youtube.com/shorts/PwAeB6sYgU4
    },
  },
];

// Main steps 1..9 (sub-steps like 5.1 / 5.2 / 5.3 / 5.4 are not counted).
export const totalMainSteps = 9;

export function getStep(number: string): Step | undefined {
  return steps.find((s) => s.number === number);
}

// Normalize teaser to an array of paragraph strings for rendering.
export function teaserParagraphs(step: Step): string[] {
  return Array.isArray(step.teaser) ? step.teaser : [step.teaser];
}

export function getStepNeighbors(number: string): { prev?: Step; next?: Step } {
  const i = steps.findIndex((s) => s.number === number);
  if (i === -1) return {};
  return {
    prev: i > 0 ? steps[i - 1] : undefined,
    next: i < steps.length - 1 ? steps[i + 1] : undefined,
  };
}
