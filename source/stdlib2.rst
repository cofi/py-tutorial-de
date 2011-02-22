.. _tut-brieftourtwo:

*********************************************************
Eine kurze Einführung in die Standardbibliothek - Teil II
*********************************************************

Dieser zweite Teil der Tour beschäftigt sich mit Modulen für
Fortgeschrittene. Diese Module sind selten in kleinen Skripten zu finden.

.. _tut-output-formatting:

Ausgabeformatierung
===================

Das Modul :mod:`reprlib` stellt eine Variante von :func:`repr` zur Verfügung, 
die für die verkürzte Anzeige von großen oder tief verschachtelten Containern 
ausgelegt ist::

   >>> import reprlib
   >>> reprlib.repr(set('supercalifragilisticexpialidocious'))
   "set(['a', 'c', 'd', 'e', 'f', 'g', ...])"

Das Modul :mod:`pprint` bietet ausgefeiltere Kontrollmöglichkeiten für die
Ausgabe von eingebauten und benutzerdefinierten Objekten, so dass diese im 
Interpreter gelesen werden können. Falls das Ergebnis länger als eine Zeile 
ist, fügt der "pretty printer" Zeilenumbrüche und Einrückungen hinzu, um die 
Datenstruktur klarer zu zeigen::

   >>> import pprint
   >>> t = [[[['schwarz', 'cyan'], 'weiß', ['grün', 'rot']], [['magenta',
   ...     'gelb'], 'blau']]]
   ...
   >>> pprint.pprint(t, width=30)
   [[[['schwarz', 'cyan'],
      'weiß',
      ['grün', 'rot']],
     [['magenta', 'gelb'],
      'blau']]]

Das Modul :mod:`textwrap` formatiert Textabsätze so, dass sie einer vorgegebenen
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
   >>> locale.setlocale(locale.LC_ALL, 'de_DE.UTF-8')
   'de_DE.UTF-8'
   >>> conv = locale.localeconv()          # die Zeichenkonventionen holen
   >>> x = 1234567.8
   >>> locale.format("%d", x, grouping=True)
   '1.234.567'
   >>> locale.format_string("%s%.*f", (conv['currency_symbol'],
   ...               conv['frac_digits'], x), grouping=True)
   '€1.234.567,80'

.. _tut-templating:

Templating
==========

Das Modul :mod:`string` enthält die vielseitige Klasse :class:`Template`, die
wegen ihrer vereinfachten Syntax zum verändern durch Endbenutzer geeignet ist.
Das ermöglicht Anwendern ihre Anwendung anzupassen, ohne die Anwendung zu
verändern.

Das Format benutzt Platzhalter, die aus ``$`` und einem gültigen
Python-Bezeichner (alphanumerische Zeichen und Unterstriche) bestehen. Umgibt man
einen Platzhalter mit geschweiften Klammern, können andere alphanumerische
Zeichen ohne Leerzeichen dazwischen folgen. Schreibt man ``$$``, erzeugt man ein
einzelnes escaptes ``$``::

   >>> from string import Template
   >>> t = Template('Die Bürger von ${village} schicken 10 € für $cause.')
   >>> t.substitute(village='Hannover', cause='den Grabenfond')
   'Die Bürger von Hannover schicken 10 € für den Grabenfond.'

Die Methode :meth:`substitute` verursacht einen :exc:`KeyError`, wenn ein
Platzhalter nicht von einem Dictionary oder einem Schlüsselwortargument
bereitgestellt wird. Bei Serienbrief-artigen Anwendungen können die vom Benutzer
bereitgestellten Daten lückenhaft sein und die Methode :meth:`safe_substitute`
ist hier deshalb passender --- sie lässt Platzhalter unverändert, wenn Daten
fehlen::

   >>> t = Template('Bringe $item $owner zurück.')
   >>> d = dict(item='die unbeladene Schwalbe')
   >>> t.substitute(d)
   Traceback (most recent call last):
     . . .
   KeyError: 'owner'
   >>> t.safe_substitute(d)
   'Bringe die unbeladene Schwalbe $owner zurück.'

Unterklassen von Template können einen eigenen Begrenzer angeben. Zum Beispiel
könnte ein Umbenennungswerkzeug für einen Fotobrowser das Prozentzeichen als
Platzhalter für das aktuelle Datum, die Fotonummer oder das Dateiformat
auswählen::

   >>> import time, os.path
   >>> photofiles = ['img_1074.jpg', 'img_1076.jpg', 'img_1077.jpg']
   >>> class BatchRename(Template):
   ...     delimiter = '%'
   >>> fmt = input('Umbenennungsschema (%d-Datum %n-Nummer %f-Format):  ')
   Umbenennungsschema (%d-Datum %n-Nummer %f-Format):  Ashley_%n%f

   >>> t = BatchRename(fmt)
   >>> date = time.strftime('%d%b%y')
   >>> for i, filename in enumerate(photofiles):
   ...     base, ext = os.path.splitext(filename)
   ...     newname = t.substitute(d=date, n=i, f=ext)
   ...     print('{0} --> {1}'.format(filename, newname))

   img_1074.jpg --> Ashley_0.jpg
   img_1076.jpg --> Ashley_1.jpg
   img_1077.jpg --> Ashley_2.jpg

Eine andere Anwendungsmöglichkeit für Templates ist die Trennung von
Programmlogik und den Details der Ausgabeformate. Dies ermöglicht es eigene
Vorlagen für XML-Dateien, Klartextberichte und HTML Web-Berichte zu ersetzen.


.. _tut-binary-formats:

Arbeit mit strukturierten binären Daten
=======================================

Das Modul :mod:`struct` stellt die Funktionen :func:`pack()` und
:func:`unpack()` bereit, mit denen strukturierte binäre Daten verarbeitet werden
können.  Das folgende Beispiel zeigt, wie die Headerinformationen aus einem
ZIP-Archiv ausgelesen werden, ohne das :mod:`zipfile`-Modul zu benutzen.  Die
Pack Codes ``"H"`` und ``"I"`` stellen zwei Byte respektive vier Byte lange
unsigned Integers dar.  Das Zeichen ``"<"`` bedeutet, dass damit Standardgrößen
gemeint sind und in der "Little Endian"-Bytereihenfolge vorliegen::

   import struct

   data = open('myfile.zip', 'rb').read()
   start = 0
   for i in range(3):                      # zeige die ersten 3 Dateiheader
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

Threading ist eine Methode, um nicht unmittelbar voneinander abhängige Prozesse
abzukoppeln. Threads können benutzt werden, um zu verhindern, dass Programme,
die während Berechnungen Benutzereingaben akzeptieren, "hängen".  Ein ähnlicher
Verwendungzweck ist es, einen Thread für I/O und einen anderen für Berechnungen
zu benutzen.

Dieser Code zeigt wie das :mod:`threading` Modul benutzt werden kann um Prozesse
im Hintergrund ablaufen zu lassen, während das Hauptprogramm parallel dazu
weiterläuft::

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
   print('Das Hauptprogramm hat auf die Beendigung des Hintergrund-Prozesses
         gewartet.')

Das Hauptproblem von Programmen mit mehreren Threads ist die Koordination der
Zugriffe auf gemeinsame Daten oder andere Ressourcen. Dafür bietet das
threading Modul einige Synchronisationsmethoden wie Locks, Events, Condition
Variables und Semaphoren an.

Der beste Weg ist es aber, allen Zugriff auf Ressourcen in einem Thread zu
koordinieren. Das :mod:`queue` Modul wird benutzt, um die Anfragen von den
anderen Threads in dieses zu bekommen. Programme die :class:`Queue` Objekte als
Kommunikation zwischen ihren Threads nutzen sind einfacher zu entwickeln,
lesbarer und stabiler.

.. _tut-logging:

Logging
=======

Das Modul :mod:`logging` ermöglicht ein ausführliches und flexibles Erstellen
von Logfiles. Im einfachsten Fall werden Logs in eine Datei geschrieben oder an
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

Python bietet automatische Speicherverwaltung (Zählen von Referenzen für die
meisten Objekte und :term:`garbage collection`). Der Speicher wird kurz nachdem
die letzte Referenz auf ein Objekt aufgelöst worden ist freigegeben.

Für die meisten Anwendungen funktioniert dieser Ansatz gut, gelegentlich kann es
allerdings auch nötig werden, Objekte nur so lange vorzuhalten, wie sie an
anderer Stelle noch verwendet werden. Das allein führt allerdings bereits dazu,
dass eine Referenz auf das Objekt erstellt wird, die es permanent macht. Mit dem
Modul :mod:`weakref` können Objekte vorgehalten werden, ohne eine Referenz zu
erstellen. Wird das Objekt nicht länger gebraucht, wird es automatisch aus einer
Tabelle mit so genannten *schwachen Referenzen* gelöscht und eine
Rückruf-Funktion für *weakref*-Objekte wird aufgerufen. Dieser Mechanismus wird
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
       d['primary']                # Eintrag wurde automatisch gelöscht
     File "C:/python33/lib/weakref.py", line 46, in __getitem__
       o = self.data[key]()
   KeyError: 'primary'


.. _tut-list-tools:

Werkzeuge zum Arbeiten mit Listen
=================================

Viele Datenstrukturen können mit dem eingebauten Listentyp dargestellt werden.
Jedoch gibt es manchmal Bedarf für eine alternative Implementierung mit anderen
Abstrichen was Leistung angeht.

Das Modul :mod:`array` stellt die Klasse :class:`array` bereit, die sich wie
eine Liste verhält, jedoch nur homogene Daten aufnimmt und diese kompakter
speichert. Das folgende Beispiel zeigt ein ``array`` von Nummern, die als
vorzeichenlose binäre Nummern der Länge 2 Byte (Typcode ``"H"``) gespeichert
werden, anstatt der bei Listen üblichen 16 Byte pro Python-Ganzzahlobjekt::

    >>> from array import array
    >>> a = array('H', [4000, 10, 700, 22222])
    >>> sum(a)
    26932
    >>> a[1:3]
    array('H', [10, 700])

Das Modul :mod:`collections` stellt die Klasse :class:`deque` bereit, das sich
wie eine Liste verhält, aber an das schneller angehängt und schneller Werte von
der linken Seite "gepopt" werden können, jedoch langsamer Werte in der Mitte
nachschlägt. Sie ist gut dazu geeignet Schlangen (Queues) und Baumsuchen, die
zuerst in der Breite suchen (breadth first tree searches)::

    >>> from collections import deque
    >>> d = deque(["task1", "task2", "task3"])
    >>> d.append("task4")
    >>> print("Handling", d.popleft())
    Handling task1

    unsearched = deque([starting_node])
    def breadth_first_search(unsearched):
       node = unsearched.popleft()
       for m in gen_moves(node):
           if is_goal(m):
               return m
           unsearched.append(m)

Zusätzlich zu alternativen Implementierungen von Listen bietet die Bibliothek
auch andere Werkzeuge wie das :mod:`bisect`-Modul an, das Funktionen zum
verändern von sortierten Listen enthält::

    >>> import bisect
    >>> scores = [(100, 'perl'), (200, 'tcl'), (400, 'lua'), (500, 'python')]
    >>> bisect.insort(scores, (300, 'ruby'))
    >>> scores
    [(100, 'perl'), (200, 'tcl'), (300, 'ruby'), (400, 'lua'), (500, 'python')]

Das :mod:`heapq`-Modul stellt Funktionen bereit, um Heaps auf der Basis von
normalen Listen zu implementieren. Der niedrigste Wert wird immer an der
Position Null gehalten. Das ist nützlich für Anwendungen, die wiederholt auf das
kleinste Element zugreifen, aber nicht die komplette Liste sortieren wollen::

    >>> from heapq import heapify, heappop, heappush
    >>> data = [1, 3, 5, 7, 9, 2, 4, 6, 8, 0]
    >>> heapify(data)                      # in Heapreihenfolge neu ordnen
    >>> heappush(data, -5)                 # neuen Eintrag hinzufügen
    >>> [heappop(data) for i in range(3)]  # die drei kleinsten Einträge holen
    [-5, 0, 1]


.. _tut-decimal-fp:

Dezimale Fließkomma-Arithmetik
==============================

Das Modul :mod:`decimal` bietet den :class:`Decimal`-Datentyp für dezimale
Fließkomma-Arithmetik. Verglichen mit der eingebauten :class:`float`-
Implementierung von binären Fließkomma-Zahlen ist die Klasse besonders
hilfreich für

* Finanzanwendungen und andere Gebiete, die eine exakte dezimale Repräsentation,
* Kontrolle über die Präzision,
* Kontrolle über die Rundung, um gesetzliche oder regulative Anforderungen zu
  erfüllen,
* das Tracking von signifikanten Dezimalstellen

erfordern, oder

* für Anwendungen bei denen der Benutzer erwartet, dass die Resultate den
  händischen Berechnungen entsprechen.

Die Berechnung einer 5% Steuer auf eine 70 Cent Telefonrechnung ergibt
unterschiedliche Ergebnisse in dezimaler und binärer Fließkomma-Repräsentation.
Der Unterschied wird signifikant, wenn die Ergebnisse auf den nächsten Cent
gerundet werden::

    >>> from decimal import *
    >>> round(Decimal('0.70') * Decimal('1.05'), 2)
    Decimal('0.74')
    >>> round(.70 * 1.05, 2)
    0.73

Das :class:`Decimal` Ergebnis behält die Null am Ende, automatisch vierstellige
Signifikanz aus den Faktoren mit zweistelliger Signifikanz folgernd.
``Decimal`` bildet die händische Mathematik nach und vermeidet Probleme, die
auftreten, wenn binäre Fließkomma-Repräsentation dezimale Mengen nicht exakt
repräsentieren können.

Die exakte Darstellung ermöglicht es der Klasse :class:`Decimal` Modulo
Berechnungen und Vergleiche auf Gleichheit durchzuführen, bei denen die binäre
Fließkomma-Repräsentation untauglich ist::

    >>> Decimal('1.00') % Decimal('.10')
    Decimal('0.00')
    >>> 1.00 % 0.10
    0.09999999999999995

    >>> sum([Decimal('0.1')]*10) == Decimal('1.0')
    True
    >>> sum([0.1]*10) == 1.0
    False

Das :mod:`decimal`-Modul ermöglicht Arithmetik mit so viel Genauigkeit, wie
benötigt wird::

    >>> getcontext().prec = 36
    >>> Decimal(1) / Decimal(7)
    Decimal('0.142857142857142857142857142857142857')

