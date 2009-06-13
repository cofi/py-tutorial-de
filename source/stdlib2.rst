.. _tut-brieftourtwo:

*********************************************************
Eine kurze Einführung in die Standardbibliothek - Teil II
*********************************************************

Dieser zweite Teil der Tour beschäftigt sich mit Modulen für
Fortgeschrittene. Diese Module sind selten in kleinen Skripten zu finden.

.. _tut-output-formatting:

Ausgabeformatierung
=================

Das Modul :mod:`reprlib` stellt eine Variante von :func:`repr` zur Verfügung, 
die für die verkürzte Anzeige von großen oder tief verschachtelten Containern 
ausgelegt ist::

   >>> import reprlib
   >>> reprlib.repr(set('supercalifragilisticexpialidocious'))
   "set(['a', 'c', 'd', 'e', 'f', 'g', ...])"

Das Modul:mod:`pprint` bietet ausgefeiltere Kontrollmöglichkeiten für die
Ausgabe von eingebauten und benutzerdefinierten Objekten, so dass diese im 
Interpreter gelesen werden können. Falls das Ergebnis länger als eine Zeile 
ist, fügt der "pretty printer" Zeilenumbrüche und Einrückungen hinzu, um die 
Datenstruktur klarer zu zeigen::

   >>> import pprint
   >>> t = [[[['black', 'cyan'], 'white', ['green', 'red']], [['magenta',
   ...     'yellow'], 'blue']]]
   ...
   >>> pprint.pprint(t, width=30)
   [[[['black', 'cyan'],
      'white',
      ['green', 'red']],
     [['magenta', 'yellow'],
      'blue']]]

Das Modul:mod:`textwrap` formatiert Textabsätze so, dass sie einer vorgegebenen
Bildschirmbreite entsprechen::
   >>> import textwrap
   >>> doc = """Die Methode wrap() verhält sich wie fill(), außer dass sie 
   ... anstatt einer einzigen großen Zeichenkette mit Zeilenumbrüchen, eine 
   ... Liste aus Zeichenketten zurückgibt um die umgebrochenen Zeilen 
   ... voneinander zu trennen."""
   ...
   >>> print(textwrap.fill(doc, width=40))
   Die Methode wrap() verhält sich wie
   fill(), außer dass sie anstatt einer
   einzigen großen Zeichenkette mit
   Zeilenumbrüchen, eine Liste aus
   Zeichenketten zurückgibt um die
   umgebrochenen Zeilen voneinander zu
   trennen.

Das Modul :mod:`locale` greift auf eine Datenbank mit länderspezifischen
Datenformaten zu. Das grouping-Attribut der format-Funktion von locale bietet 
eine einfache Möglichkeit um Zahlen mit Tausendertrennzeichen zu formatieren::

   >>> import locale
   >>> locale.setlocale(locale.LC_ALL, 'English_United States.1252')
   'English_United States.1252'
   >>> conv = locale.localeconv()          # get a mapping of conventions
   >>> x = 1234567.8
   >>> locale.format("%d", x, grouping=True)
   '1,234,567'
   >>> locale.format("%s%.*f", (conv['currency_symbol'],
   ...               conv['frac_digits'], x), grouping=True)
   '$1,234,567.80'

.. _tut-multi-threading:

Multi-threading
===============

Threading ist eine Methode um nicht unmittelbar voneinander abhängige
Prozesse abzukoppeln.  Threads können benutzt werden um zu verhindern, dass
Programme, die während Berechnungen Benutzereingaben akzeptieren, "hängen".
Ein ähnlicher Verwendungzweck ist es, einen Thread für I/O und einen anderen
für Berechnungen zu benutzen.

Dieser Code zeigt wie das :mod:`threading` Modul benutzt werden kann um 
Prozesse im Hintergrund ablaufen zu lassen, während das Hauptprogramm
parallel dazu weiterläuft.::

   import threading, zipfile

   class AsyncZip(threading.Thread):
       def __init__(self, infile, outfile):
           threading.Thread.__init__(self)
           self.infile = infile
           self.outfile = outfile
       def run(self):
           f = zipfile.ZipFile(self.outfile, 'w', zipfile.ZIP_DEFLATED)
           f.write(self.infile)
           f.close()
           print('Zippen im Hintergrund abgeschlossen:', self.infile)

   background = AsyncZip('mydata.txt', 'myarchive.zip')
   background.start()
   print('Das Hauptprogramm läuft inzwischen weiter.')

   background.join()    # Warten bis das Thread beendet.
   print('Das Hauptprogramm hat auf die Beendigung des Hintergrund-Prozesses gewartet.')

Das Hauptproblem von Programmen mit mehreren Threads ist die Koordination
der Zugriffe auf gemeinsame Daten oder andere Ressourcen.  Dafür bietet
das threading Modul einige Synchronisationsmethoden wie Locks, Events,
Condition Variables und Semaphoren an.

Der beste Weg ist es aber, allen Zugriff auf Ressourcen in einem Thread zu
koordinieren. Das :mod:`queue` Modul wird benutzt, um die Anfragen von den
anderen Threads in dieses zu bekommen.  Programme die :class:`Queue` Objekte
als Kommunikation zwischen ihren Threads nutzen sind einfacher zu entwickeln,
lesbarer und stabiler.

