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

.. _tut-binary-formats:

Arbeit mit strukturierten binären Daten
=======================================

Das Modul :mod:`struct` stellt die Funktionen :func:`pack()` und :func:`unpack()`
bereit, mit denen strukturierte binäre Daten verarbeitet werden können.  Das
folgende Beispiel zeigt, wie die Headerinformationen aus einem ZIP-Archiv
ausgelesen werden, ohne das :mod:`zipfile`-Modul zu benutzen.
Die Pack Codes ``"H"`` und ``"I"`` stellen zwei Byte respektive vier Byte lange
unsigned Integers dar.  Das Zeichen ``"<"`` bedeutet, dass damit Standardgrößen
gemeint sind und in der Little Endian-Bytereihenfolge vorliegen::

   import struct

   data = open('myfile.zip', 'rb').read()
   start = 0
   for i in range(3):                      # show the first 3 file headers
       start += 14
       fields = struct.unpack('<IIIHH', data[start:start+16])
       crc32, comp_size, uncomp_size, filenamesize, extra_size = fields

       start += 16
       filename = data[start:start+filenamesize]
       start += filenamesize
       extra = data[start:start+extra_size]
       print filename, hex(crc32), comp_size, uncomp_size

       start += extra_size + comp_size     # skip to the next header

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

   background.join()    # Warten bis sich der Thread beendet.
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

.. _tut-logging:

Logging
=======

Das Modul :mod:`logging` ermöglicht ausführliches und flexibles Erstellen von
Logfiles. Im einfachsten Fall werden Logs in eine Datei geschrieben oder an
``sys.stderr`` geschickt::

   import logging
   logging.debug('Debugging Information')
   logging.info('Information')
   logging.warning('Warnung:Datei %s nicht gefunden', 'server.conf')
   logging.error('Fehler')
   logging.critical('Kritischer Fehler!')

Die Ausgabe von Meldungen der Stufen *info* und *debug* wird standardmäßig
unterdrückt; übrige Meldungen werden an ``sys.stderr`` geschickt. Darüber hinaus
können Meldungen auch per E-Mail, über Datenpakete (UDP), Sockets (TCP) oder an
einen HTTP-Server ausgeliefert werden. Filter können weiterhin entscheiden,
worüber Meldungen ausgegeben werden - je nach Priorität: :const:`DEBUG`,
:const:`INFO`, :const:`WARNING`, :const:`ERROR` und :const:`CRITICAL`.

Das Logging-system kann entweder direkt mittels Python konfiguriert werden oder
seine Konfiguration aus einer vom Benutzer definierbaren Konfigurationsdatei
lesen, ohne dass dabei das Programm selbst geändert werden muss.


.. _tut-weak-references:

Weak References
===============

Python bietet automatische Speicherverwaltung - Zählen von Referenzen für die
meisten Objekte und :term:`garbage collection`. Nachdem die letzte Referenz auf
ein Objekt aufgelöst worden ist, wird der Speicher bald freigegeben.

Für die meisten Anwendungen funktioniert dieser Ansatz gut, gelegentlich kann es
allerdings auch nötig werden, Objekte nur so lange vorzuhalten, wie sie an
anderer Stelle noch verwendet werden. Das allein führt allerdings bereits dazu,
dass eine Referenz auf das Objekt erstellt wird, die es permanent macht. Mit dem
Modul :mod:`weakref` können Objekte vorgehalten werden, ohne eine Referenz zu
erstellen. Wird das Objekt nicht länger gebraucht, wird es automatisch aus einer
Tabelle mit so genannten *schwachen Referenzen* gelöscht und eine
Rückruffunktion für *weakref*-Objekte wird aufgerufen. Dieser Mechanismus wird
etwa verwendet, um Objekte zwischenzuspeichern, deren Erstellung besonders
aufwändig ist::

   >>> import weakref, gc
   >>> class A:
   ...     def __init__(self, value):
   ...             self.value = value
   ...     def __repr__(self):
   ...             return str(self.value)
   ...
   >>> a = A(10)                   # Eine Referenz erstellen
   >>> d = weakref.WeakValueDictionary()
   >>> d['primary'] = a            # Erstellt keine Referenz
   >>> d['primary']                # Klappt, falls Objekt noch vorhanden
   10
   >>> del a                       # Einzige Referenz löschen
   >>> gc.collect()                # Garbage collector aufrufen
   0
   >>> d['primary']                # Eintrag wurde automatisch gelöscht
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
       d['primary']                # entry was automatically removed
     File "C:/python31/lib/weakref.py", line 46, in __getitem__
       o = self.data[key]()
   KeyError: 'primary'
