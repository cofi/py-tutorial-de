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
:func:`open` überschreit, die sich vollkommen anders verhält.

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
   ['demo.py', 'one', 'two', 'three']

Das Modul 'mod'`getopt` verarbeitet *sys.argv* gemäß den üblichen Konventionen
der aus Unix bekannten :func:`getopt`-Funktion. Erweiterte und flexiblere
Möglichkeiten bietet das Modul :mod:`optparse`.

.. _tut-stderr:

Umleitung von Fehlermeldungen und Programmabbruch
=================================================

Das Modul :mod:`sys` hat darüber hinaus auch Attribute für *stdin*, *stdout*
und *stderr*. Letzteres ist vor allem bei der Ausgabe von Warnungen und
Fehlermeldungen nützlich, etwa wenn *stdout* umgeleitet worden ist::

   >>> sys.stderr.write('Warning, log file not found starting a new one\n')
   Warning, log file not found starting a new one

Der direkteste Weg, ein Script zu beenden, führt über ``sys.exit()``.

.. _tut-string-pattern-matching:

Muster in Strings
=================

Das Modul :mod:`re` ermöglicht die Arbeit mit regulären Ausdrücken (*regular
expressions*) zur erweiterten Verarbeitung von Strings. Reguläre Ausdrücke
eignen sich vor allem für komplizierte Suchen und Änderungen an Strings::

   >>> import re
   >>> re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
   ['foot', 'fell', 'fastest']
   >>> re.sub(r'(\b[a-z]+) \1', r'\1', 'cat in the the hat')
   'cat in the hat'

Solange Allerdings nur einfache Änderungen vorgenommen werden müssen, sollte
man eher zu den normalen Methoden von Strings greifen, da diese einfacher zu
lesen und korrigieren sind::

   >>> 'tea for too'.replace('too', 'two')
   'tea for two'


.. _tut-mathematics:

Mathematik
==========

Mit dem Modul :mod:`math` kann man tieferliegende Funktionen der C-Bibliothek
für Fließkommaberechnungen verwenden::

   >>> import math
   >>> math.cos(math.pi / 4.0)
   0.70710678118654757
   >>> math.log(1024, 2)
   10.0

Mit dem Modul :mod:`random` lassen sich zufällige Auswahlen treffen::

   >>> import random
   >>> random.choice(['apple', 'pear', 'banana'])
   'apple'
   >>> random.sample(xrange(100), 10)   # sampling without replacement
   [30, 83, 16, 4, 8, 81, 41, 50, 18, 33]
   >>> random.random()    # random float
   0.17970987693706186
   >>> random.randrange(6)    # random integer chosen from range(6)
   4


.. _tut-internet-access:

Zugriff auf das Internet
========================

Zum Zugriff auf das Internet und für die Arbeit mit Internetprotokollen stehen
verschiedene Module bereit. Zwei der einfachsten sind :mod:`urllib2` zum
Herunterladen von Daten über URLs und :mod:`smtplib` zum Versand von E-Mails::

   >>> import urllib2
   >>> for line in urllib2.urlopen('http://tycho.usno.navy.mil/cgi-bin/timer.pl'):
   ...     if 'EST' in line or 'EDT' in line:  # look for Eastern Time
   ...         print line

   <BR>Nov. 25, 09:43:32 PM EST

   >>> import smtplib
   >>> server = smtplib.SMTP('localhost')
   >>> server.sendmail('soothsayer@example.org', 'jcaesar@example.org',
   ... """To: jcaesar@example.org
   ... From: soothsayer@example.org
   ...
   ... Beware the Ides of March.
   ... """)
   >>> server.quit()

(Anmerkung: das zweite Beispiel benötigt einen Mailserver auf localhost.)
