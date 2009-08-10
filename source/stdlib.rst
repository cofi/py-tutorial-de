.. _tut-brieftour:

***********************************************
Eine kurze Einführung in die Standardbibliothek
***********************************************


.. _tut-os-interface:

Schnittstelle zum Betriebssystem
================================

Im Modul :mod:`os` findet man Dutzende von Funktionen, um mit dem
Betriebssystem zu interagieren::

   >>> import os
   >>> os.system('time 0:02')
   0
   >>> os.getcwd()      # Das aktuelle Verzeichnis
   'C:\\Python26'
   >>> os.chdir('/server/accesslogs')

Dabei sollte unbedingt beachtet werden, ``import os`` statt ``from os import
*`` zu verwenden, da ansonsten :func:`os.open` die eingebaute Funktion
:func:`open` überschreibt, die sich vollkommen anders verhält.

.. index:: builtin: help

Die eingebauten Funktionen :func:`dir` und :func:`help` sind gerade beim
Gebrauch der interaktiven Python-Shell nützlich, wenn man mit großen Modulen
wie :mod:`os` arbeitet::

   >>> import os
   >>> dir(os)
   <eine Liste aller Funktionen des Moduls>
   >>> help(os)
   <eine ausführliche Anleitung, erstellt aus den Docstrings des Moduls>

Typische Arbeiten mit Dateien und Verzeichnissen erleichtert das Modul
:mod:`shutil`, das eine einfachere Schnittstelle bereitstellt.::

   >>> import shutil
   >>> shutil.copyfile('data.db', 'archive.db')
   >>> shutil.move('/build/executables', 'installdir')


.. _tut-file-wildcards:

Platzhalter in Dateinamen
=========================

Mit dem Modul :mod:`glob` können Platzhalter bei der Suche nach Datei- oder
Verzeichnisnamen verwendet werden::

   >>> import glob
   >>> glob.glob('*.py')
   ['primes.py', 'random.py', 'quote.py']

Argumente in der Befehlszeile
=============================

Die meisten Skripte müssen Argumente aus der Befehlszeile verarbeiten. Diese
Argumente werden als Liste im Attribut *argv* des Moduls 'mod'`sys`
gespeichert. Die folgende Ausgabe erhält man, wenn man ``python demo.py
eins zwei drei`` in der Eingabeaufforderung des Betriebssystems eingibt::

   >>> import sys
   >>> print sys.argv
   ['demo.py', 'eins', 'zwei', 'drei']

Das Modul :mod:`getopt` verarbeitet *sys.argv* gemäß der üblichen Konventionen
der aus Unix bekannten :func:`getopt`-Funktion. Erweiterte und flexiblere
Möglichkeiten bietet das Modul :mod:`optparse`.

.. _tut-stderr:

Umleitung von Fehlermeldungen und Programmabbruch
=================================================

Das Modul :mod:`sys` hat darüber hinaus auch Attribute für *stdin*, *stdout*
und *stderr*. Letzteres ist vor allem bei der Ausgabe von Warnungen und
Fehlermeldungen nützlich, etwa wenn *stdout* umgeleitet worden ist::

   >>> sys.stderr.write('Warnung, Log-Datei konnte nicht gefunden werden\n')
   Warnung, Log-Datei konnte nicht gefunden werden

Der direkteste Weg, ein Skript zu beenden, führt über ``sys.exit()``.

.. _tut-string-pattern-matching:

Muster in Zeichenketten
=======================

Das Modul :mod:`re` erlaubt die Arbeit mit regulären Ausdrücken (*regular
expressions*) für komplexe Zeichenketten-Operationen. Reguläre Ausdrücke
eignen sich vor allem für komplizierte Suchen und Änderungen an Zeichenketten::

   >>> import re
   >>> re.findall(r'\bk[a-z]*', 'drei kleine katzen')
   ['kleine', 'katzen']
   >>> re.sub(r'(\b[a-z]+) \1', r'\1', 'Die Katze im im Hut')
   'Die Katze im Hut'

Solange allerdings nur einfache Änderungen vorgenommen werden müssen, sollte man
eher zu den normalen Methoden der Zeichenketten greifen, da diese einfacher zu
lesen und zu verstehen sind::

   >>> 'Tee für zwo'.replace('zwo', 'zwei')
   'Tee für zwei'


.. _tut-mathematics:

Mathematik
==========

Das Modul :mod:`math` ermöglicht den Zugriff auf Funktionen der
zugrundeliegenden C-Bibliothek für Fließkomma-Mathematik::

   >>> import math
   >>> math.cos(math.pi / 4.0)
   0.70710678118654757
   >>> math.log(1024, 2)
   10.0

Mit dem Modul :mod:`random` lassen sich zufällige Auswahlen treffen::

   >>> import random
   >>> random.choice(['Apfel', 'Birne', 'Banane'])
   'Apfel'
   >>> random.sample(xrange(100), 10)   # Stichprobe
   [30, 83, 16, 4, 8, 81, 41, 50, 18, 33]
   >>> random.random()    # Zufällige Fließkommazahl
   0.17970987693706186
   >>> random.randrange(6)    # Zufällige Ganzzahl aus range(6)
   4

Das `SciPy-Projekt <http://scipy.org/>`_ hat viele weitere Module für numirische
Berechnungen.

.. _tut-internet-access:

Zugriff auf das Internet
========================

Zum Zugriff auf das Internet und für die Arbeit mit Internetprotokollen stehen
verschiedene Module bereit. Zwei der einfachsten sind :mod:`urllib.request` zum
Herunterladen von Daten über URLs und :mod:`smtplib` zum Versand von E-Mails::

   >>> import urllib2
   >>> for line in urllib2.urlopen('http://tycho.usno.navy.mil/cgi-bin/timer.pl'):
   ...     if 'EST' in line or 'EDT' in line:  # Nach Eastern Time suchen
   ...         print line

   <BR>Nov. 25, 09:43:32 PM EST

   >>> import smtplib
   >>> server = smtplib.SMTP('localhost')
   >>> server.sendmail('soothsayer@example.org', 'jcaesar@example.org',
   ... """To: jcaesar@example.org
   ... From: soothsayer@example.org
   ...
   ... Nimm dich in Acht vor den Iden des März!
   ... """)
   >>> server.quit()

(Anmerkung: das zweite Beispiel benötigt einen Mailserver auf localhost.)


.. _tut-dates-and-times:

Datum und Uhrzeit
=================

Das Modul :mod:`datetime` stellt Klassen sowohl für einfache als auch
kompliziertere Arbeiten mit Datum und Uhrzeit bereit. Während das Rechnen mit
Datum und Uhrzeit zwar unterstützt wird, liegt das Hauptaugenmerk der
Implementierung auf Attributzugriffen für Ausgabeformatierung und -manipulation.
Die Verwendung von Zeitzonen wird ebenfalls unterstützt. :: 

   # Ein Datum lässt sich leicht aufbauen
   >>> from datetime import date
   >>> now = date.today()
   >>> now
   datetime.date(2003, 12, 2)
   >>> now.strftime("%m-%d-%y. %d %b %Y ist ein %A am %d. Tag des %B.")
   '12-02-03. 02 Dec 2003 ist ein Tuesday am 02. Tag des December.'

   # Mit dem Datum lässt sich rechnen
   >>> geburtstag = date(1964, 7, 31)
   >>> alter = jetzt - geburtstag
   >>> alter.days
   14368

.. _tut-data-compression:

Datenkompression
================

Die üblichen Dateiformate zur Archivierung und Kompression werden direkt in
eigenen Modulen unterstützt. Darunter: :mod:`zlib`, :mod:`gzip`, :mod:`bz2`,
:mod:`zipfile` und :mod:`tarfile`. ::

   >>> import zlib
   >>> s = 'Wenn Fliegen hinter Fliegen fliegen'
   >>> len(s)
   35
   >>> t = zlib.compress(s)
   >>> len(t)
   31
   >>> zlib.decompress(t)
   'Wenn Fliegen hinter Fliegen fliegen'
   >>> zlib.crc32(s)
   1048664767


.. _tut-performance-measurement:

Performancemessung
==================

Viele Benutzer von Python interessieren sich sehr für die jeweiligen
Geschwindigkeitsunterschiede verschiedener Lösungen für ein Problem. Python
stellt hier ein Messinstrument zur Verfügung, mit dem diese Fragen beantwortet
werden können.

Es könnte etwa verlockend sein, statt Argumente einfach gegeneinander
auszutauschen, Tuple und ihr Verhalten beim *Packing*/*Unpacking* zu verwenden.
Das Modul :mod:`timeit` zeigt schnell einen eher bescheidenen
Geschwindigkeitsvorteil auf::

   >>> from timeit import Timer
   >>> Timer('t=a; a=b; b=t', 'a=1; b=2').timeit()
   0.57535828626024577
   >>> Timer('a,b = b,a', 'a=1; b=2').timeit()
   0.54962537085770791

Die Zeitmessung mit :mod:`timeit` bietet hohe Genauigkeit. Dahingegen lassen
sich mit :mod:`profile` und :mod:`pstats` zeitkritische Bereiche in größeren
Abschnitten von Programmcode auffinden.


.. _tut-quality-control:

Qualitätskontrolle
==================

Ein Ansatz, um Software hoher Qualität zu entwickeln, ist es Tests für jede
Funktion schreiben, die regelmäßig während des Entwicklungsprozesses ausgeführt
werden.

Das Modul :mod:`doctest` durchsucht ein Modul nach Tests in seinen Docstrings
und führt diese aus. Das Erstellen eines Tests ist sehr einfach, dazu muss
lediglich ein typischer Aufruf der Funktion samt seiner Rückgaben in den
Docstring der Funktion kopiert werden. Dadurch wird gleichzeitig die
Dokumentation verbessert, da Benutzer direkt ein Beispiel mitgeliefert
bekommen. Darüber hinaus lässt sich so sicherstellen, dass Code und
Dokumentation auch nach Änderungen noch übereinstimmen::

   def durchschnitt(values):
       """Berechnet das arithmetische Mittel aus einer Liste von Zahlen

       >>> print(durchschnitt([20, 30, 70]))
       40.0
       """
       return sum(values, 0.0) / len(values)

   import doctest
   doctest.testmod()   # Führt den Test automatisch durch

Das Modul :mod:`unittest` funktioniert nicht ganz so einfach, dafür lassen sich
damit auch umfangreichere Tests erstellen, die dazu gedacht sind, in einer
eigenen Datei verwaltet zu werden::

   import unittest

   class TestStatisticalFunctions(unittest.TestCase):

       def test_durchschnitt(self):
           self.assertEqual(durchschnitt([20, 30, 70]), 40.0)
           self.assertEqual(round(durchschnitt([1, 5, 7]), 1), 4.3)
           self.assertRaises(ZeroDivisionError, durchschnitt, [])
           self.assertRaises(TypeError, durchschnitt, 20, 30, 70)

   unittest.main() # Calling from the command line invokes all tests


.. _tut-batteries-included:

Batteries Included
===================

Bei Python folgt der Philosophie "Batteries Included". Am besten lässt sich das
an den komplexen und robusten Möglichkeiten seiner größeren Pakete sehen. Ein
paar Beispiele:

* Die Module :mod:`xmlrpc.client` and :mod:`xmlrpc.server` erleichtern Remote
  Procedure Calls (RPC) enorm. Trotz ihrer Namen ist allerdings keine direkte
  Kenntnis oder Handhabung von XML notwendig.

* Das Modul :mod:`email` ist eine Bibliothek zur Arbeit mit E-Mails, inklusive
  MIME und anderen RFC 2822-basierten Nachrichten. Anders als :mod:`smtplib`
  und :mod:`poplib`, mit denen Nachrichten versandt und empfangen werden können,
  ist :mod:`email` dafür zuständig, komplizierte Nachrichten (einschließlich
  Anhänge) zu konstruieren oder zu analysieren. Weiterhin erleichtert es den
  Umgang mit im Internet verwendeten Encodings und den Headern.

* :mod:`xml.dom` und :mod:`xml.sax` halten eine robuste Untestützung für dieses
  populäre Datenaustausch-Format bereit. Mit :mod:`csv` lässt sich in ein
  allgemein gebräuchliches Datenbankformat schreiben und daraus lesen. Diese
  Module erleichtern den Austausch von Daten zwischen Python und anderen
  Werkzeugen enorm. 

* Zur Internationalisierung von Anwendungen stehen unter anderem die Module
  :mod:`gettext`, :mod'`locale` und :mod:`codecs` zur Verfügung.
