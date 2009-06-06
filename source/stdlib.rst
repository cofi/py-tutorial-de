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



