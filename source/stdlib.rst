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

Alltägliche Arbeiten mit Dateien und Verzeichnissen erleichtert das Modul :mod:`shutil`, das etwas allgemeiner gehalten ist.::

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

Die meisten Scripts müssen auf Argumente in der Befehlszeile eingehen. Diese Argumente werden im Attribut *argv* des Moduls 'mod'`sys` als Liste gespeichert. Die folgende Ausgabe etwas erhält man, wenn man ``python demo.py one two three`` auf der Befehlszeile eingibt::

   >>> import sys
   >>> print sys.argv
   ['demo.py', 'one', 'two', 'three']

Das Modul 'mod'`getopt` verarbeitet *sys.argv* gemäß den üblichen Konventionen der aus Unix bekannten :func:`getopt`-Funktion. Erweiterte und flexiblere Möglichkeiten bietet das Modul :mod:`optparse`.

.. _tut-stderr:

Umleitung von Fehlermeldungen und Programmabbruch
=================================================

Das Modul :mod:`sys` hat darüber hinaus auch Attribute für *stdin*, *stdout* und *stderr*. Letzteres ist vor allem bei der Ausgabe von Warnungen und Fehlermeldungen nützlich, etwa wenn *stdout* umgeleitet worden ist::

   >>> sys.stderr.write('Warning, log file not found starting a new one\n')
   Warning, log file not found starting a new one

Der direkteste Weg, ein Script zu beenden, führt über ``sys.exit()``.
