.. _tut-brieftour:

***********************************************
Eine kurze Einführung in die Standardbibliothek
***********************************************


.. _tut-os-interface:

Interface zum Betriebssystem
============================

Im Modul :mod:`os` findet man dutzende von Funktionen, um mit dem
Betriebssystem zu arbeiten::

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
Gebrauch der interaktiven Python-Shell nützlich, wenn man mit großen Modulen,
wie :mod:`os` arbeitet::

   >>> import os
   >>> dir(os)
   <eine Liste aller Funktionen des Moduls>
   >>> help(os)
   <eine ausführliche Anleitung, erstellt aus den Docstrings des Moduls>

Alltägliche Arbeiten mit Dateien und Verzeichnissen erleichtert das Modul
:mod:`shutil`, das etwas allgemeiner gehalten ist.::

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

Die meisten Scripts müssen auf Argumente in der Befehlszeile eingehen. Diese
Argumente werden im Attribut *argv* des Moduls 'mod'`sys` als Liste
gespeichert. Die folgende Ausgabe etwas erhält man, wenn man ``python demo.py
one two three`` auf der Befehlszeile eingibt::

   >>> import sys
   >>> print sys.argv
   ['demo.py', 'eins', 'zwei', 'drei']

Das Modul 'mod'`getopt` verarbeitet *sys.argv* gemäß den üblichen Konventionen
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

Der direkteste Weg, ein Script zu beenden, führt über ``sys.exit()``.

.. _tut-string-pattern-matching:

Muster in Strings
=================

Das Modul :mod:`re` ermöglicht die Arbeit mit regulären Ausdrücken (*regular
expressions*) zur erweiterten Verarbeitung von Strings. Reguläre Ausdrücke
eignen sich vor allem für komplizierte Suchen und Änderungen an Strings::

   >>> import re
<<<<<<< local
   >>> re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
   ['foot', 'fell', 'fastest']
   >>> re.sub(r'(\b[a-z]+) \1', r'\1', 'cat in the the hat')
   'cat in the hat'
=======
   >>> re.findall(r'\bk[a-z]*', 'drei kleine katzen')
   ['kleine', 'katzen']
   >>> re.sub(r'(\b[a-z]+) \1', r'\1', 'Die Katze im im Hut')
   'Die Katze im Hut'
>>>>>>> other

Solange Allerdings nur einfache Änderungen vorgenommen werden müssen, sollte
man eher zu den normalen Methoden von Strings greifen, da diese einfacher zu
lesen und korrigieren sind::

<<<<<<< local
   >>> 'tea for too'.replace('too', 'two')
   'tea for two'
=======
   >>> 'Tee für zwo'.replace('zwo', 'zwei')
   'Tee für zwei'
>>>>>>> other


.. _tut-mathematics:

Mathematik
==========

<<<<<<< local
Mit dem Modul :mod:`math` kann man tieferliegende Funktionen der C-Bibliothek
=======
Mit dem Modul :mod:`math` kann man tiefer liegende Funktionen der C-Bibliothek
>>>>>>> other
für Fließkommaberechnungen verwenden::

   >>> import math
   >>> math.cos(math.pi / 4.0)
   0.70710678118654757
   >>> math.log(1024, 2)
   10.0

Mit dem Modul :mod:`random` lassen sich zufällige Auswahlen treffen::

   >>> import random
<<<<<<< local
   >>> random.choice(['apple', 'pear', 'banana'])
   'apple'
   >>> random.sample(xrange(100), 10)   # sampling without replacement
=======
   >>> random.choice(['Apfel', 'Birne', 'Banane'])
   'Apfel'
   >>> random.sample(xrange(100), 10)   # Stichprobe
>>>>>>> other
   [30, 83, 16, 4, 8, 81, 41, 50, 18, 33]
<<<<<<< local
   >>> random.random()    # random float
=======
   >>> random.random()    # Zufällige Fließkommazahl
>>>>>>> other
   0.17970987693706186
<<<<<<< local
   >>> random.randrange(6)    # random integer chosen from range(6)
=======
   >>> random.randrange(6)    # Zufällige Ganzzahl aus range(6)
>>>>>>> other
   4


.. _tut-internet-access:

Zugriff auf das Internet
========================

Zum Zugriff auf das Internet und für die Arbeit mit Internetprotokollen stehen
verschiedene Module bereit. Zwei der einfachsten sind :mod:`urllib2` zum
Herunterladen von Daten über URLs und :mod:`smtplib` zum Versand von E-Mails::

   >>> import urllib2
   >>> for line in urllib2.urlopen('http://tycho.usno.navy.mil/cgi-bin/timer.pl'):
<<<<<<< local
   ...     if 'EST' in line or 'EDT' in line:  # look for Eastern Time
=======
   ...     if 'EST' in line or 'EDT' in line:  # Nach Eastern Time suchen
>>>>>>> other
   ...         print line

   <BR>Nov. 25, 09:43:32 PM EST

   >>> import smtplib
   >>> server = smtplib.SMTP('localhost')
   >>> server.sendmail('soothsayer@example.org', 'jcaesar@example.org',
   ... """To: jcaesar@example.org
   ... From: soothsayer@example.org
   ...
<<<<<<< local
   ... Beware the Ides of March.
=======
   ... Nimm dich in Acht vor den Iden des März!
>>>>>>> other
   ... """)
   >>> server.quit()

(Anmerkung: das zweite Beispiel benötigt einen Mailserver auf localhost.)


.. _tut-dates-and-times:

Datum und Uhrzeit
=================

Das Modul :mod:`datetime` stellt Klassen sowohl für einfache als auch
kompliziertere Arbeiten mit Datum und Uhrzeit bereit. Während das Rechnen mit
Datum und Uhrzeit zwar unterstützt wird, liegt das Hauptaugenmerk der
Implementierung auf Attributszugriff für Ausgabeformatierung und -manipulation.
Die Verwendung von Zeitzonen wird ebenfalls unterstützt. :: 

<<<<<<< local
   # dates are easily constructed and formatted
=======
   # Ein Datum lässt sich leicht aufbauen
>>>>>>> other
   >>> from datetime import date
<<<<<<< local
   >>> now = date.today()
   >>> now
=======
   >>> jetzt = date.today()
   >>> jetzt
>>>>>>> other
   datetime.date(2003, 12, 2)
<<<<<<< local
   >>> now.strftime("%m-%d-%y. %d %b %Y is a %A on the %d day of %B.")
   '12-02-03. 02 Dec 2003 is a Tuesday on the 02 day of December.'
=======
   >>> jetzt.strftime("%m-%d-%y. %d %b %Y ist ein %A am %d. Tag des %B.")
   '12-02-03. 02 Dec 2003 ist ein Tuesday am 02. Tag des December.'
>>>>>>> other

<<<<<<< local
   # dates support calendar arithmetic
   >>> birthday = date(1964, 7, 31)
   >>> age = now - birthday
   >>> age.days
=======
   # Mit dem Datum lässt sich rechnen
   >>> geburtstag = date(1964, 7, 31)
   >>> alter = jetzt - geburtstag
   >>> alter.days
>>>>>>> other
   14368

.. _tut-data-compression:

Datenkompression
================

Die üblichen Dateiformate zur Archivierung und Kompression werden direkt in
eigenen Modulen unterstützt. Darunter: :mod:`zlib`, :mod:`gzip`, :mod:`bz2`,
:mod:`zipfile` und :mod:`tarfile`. ::

   >>> import zlib
<<<<<<< local
   >>> s = 'witch which has which witches wrist watch'
=======
   >>> s = 'Wenn Fliegen hinter Fliegen fliegen'
>>>>>>> other
   >>> len(s)
<<<<<<< local
   41
=======
   35
>>>>>>> other
   >>> t = zlib.compress(s)
   >>> len(t)
<<<<<<< local
   37
=======
   31
>>>>>>> other
   >>> zlib.decompress(t)
<<<<<<< local
   'witch which has which witches wrist watch'
=======
   'Wenn Fliegen hinter Fliegen fliegen'
>>>>>>> other
   >>> zlib.crc32(s)
<<<<<<< local
   226805979
=======
   1048664767
>>>>>>> other


.. _tut-performance-measurement:

Performancemessung
==================

Viele Benutzer von Python interessieren sich sehr für die jeweiligen
Geschwindigkeitsunterschiede verschiedener Herangehensweisen an ein Problem.
Python stellt hier ein Messinstrument zur Verfügung, mit dem diese Fragen
beantwortet werden können.

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

Um hohe Qualität der entwickelten Software zu gewährleisten, kann man etwa
Tests für jede Funktion schreiben, die regelmäßig während des
Entwicklungsprozesses durchgeführt werden.

Das Modul :mod:`doctest` durchsucht ein Modul nach Tests in seinen Docstrings
und führt diese durch. Das Erstellen eines Tests ist sehr einfach, dazu muss
lediglich ein typischer Aufruf der Funktion samt seiner Rückgaben in den
Docstring der Funktion kopiert werden. Dadurch wird gleichzeitig die
Dokumentation verbessert, da Benutzer direkt ein Beispiel mitgeliefert
bekommen. Darüber hinaus lässt sich so sicherstellen, dass Code und
Dokumentation auch nach Änderungen noch übereinstimmen::

   def durchschnitt(values):
       """Berechnet das arithmetische Mittel aus einer Liste von Zahlen

       >>> print durchschnitt([20, 30, 70])
       40.0
       """
       return sum(values, 0.0) / len(values)

   import doctest
   doctest.testmod()   # Führt den Test automatisch durch

Etwas anspruchsvoller ist das Modul :mod:`unittest`, dafür lassen sich damit
auch anspruchsvollere Tests erstellen, die in einer eigenen Datei verwaltet
werden::

   import unittest

   class TestStatisticalFunctions(unittest.TestCase):

       def test_durchschnitt(self):
           self.assertEqual(durchschnitt([20, 30, 70]), 40.0)
           self.assertEqual(round(durchschnitt([1, 5, 7]), 1), 4.3)
           self.assertRaises(ZeroDivisionError, durchschnitt, [])
           self.assertRaises(TypeError, durchschnitt, 20, 30, 70)

   unittest.main() # Calling from the command line invokes all tests


.. _tut-batteries-included:

Batteries Includeed
===================

Bei Python gilt der Slogan "Batteries Included". Am besten lässt sich das anhand seiner größeren Pakete aufzeigen. Beispiele:

* Die Module :mod:`xmlrpclib` and :mod:`SimpleXMLRPCServer` erleichtern RPC
  enorm. Trotz ihrer Namen ist übrigens keine Kenntnis von XML notwendig

* Das Modul :mod:`email` ist eine Bibliothek zur Arbeit mit E-Mails, auch mit
  MIME und anderen RFC 2822-basierten Nachrichten. Anders als :mod:`smtplib`
  und :mod:`poplib`, mit denen Nachrichten versandt und empfangen werden
  können, ist :mod:`email` dafür zuständig, komplizierte Nachrichten
  (einschließlich Anhänge) zu konstruieren oder zu analysieren. Weiterhin
  erleichtert es den Umgang mit im Internet verwendeten Encodings und den
  Headern.

* :mod:`xml.dom` und :mod:`xml.sax` dienen dem Umgang mit XML. Mit :mod:`csv`
  lässt sich in ein allgemein gebräuchliches Datenbankformat schreiben und
  daraus lesen. Diese Module erleichtern den Austausch von Daten zwischen
  Python und anderen Werkzeugen ernorm. 

* Zur Internationalisierung von Anwendungen stehen unter anderem die Module
  :mod:`gettext`, :mod'`locale` und :mod:`codecs` zur Verfügung.
