.. _tut-brieftourtwo:

*********************************************************
Eine kurze Einführung in die Standardbibliothek - Teil II
*********************************************************

Dieser zweite Teil der Tour beschäftigt sich mit Modulen für
Fortgeschrittene. Diese Module sind selten in kleinen Skripten zu finden.

.. _tut-multi-threading:

Multi-threading
===============

Threading ist eine Methode um nicht unmittelbar voneinander abhängige
Prozesse abzukoppeln.  Threads können benutzt werden um zu verhindern, dass
Programme die während Berechnungen Benutzereingaben akzeptieren "hängen".
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

