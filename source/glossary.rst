.. _glossary: 

*******
Glossar
*******

.. glossary::

   bytecode
      Die interne Darstellung eines Python-Programmes im Interpreter,
      Python-Programme werden zu ihm kompiliert.  Der Bytecode wird in ``.pyc``-
      und ``.pyo``-Dateien gespeichert, so dass das Ausführen derselben Datei
      beim zweiten Mal schneller ist (da die erneute Kompilierung zu Bytecode
      vermieden werden kann).  Diese "Zwischensprache" (*intermediate language*)
      ist dazu gedacht auf einer :term:`virtual machine` (Virtuellen Maschine)
      ausgeführt zu werden, die den Maschinencode zum jeweiligen Bytecode
      ausführt.

   garbage collection
      Der Prozess des Freigebens nicht mehr benötigten Speichers.  Pythons
      garbage collection erfolgt mittels des Zählens von Referenzen (*reference
      counting*) und einem zyklischen Garbage Collectors, der imstande ist
      Referenzzyklen zu entdecken und aufzubrechen.

   generator
      Eine Funktion die einen Iterator zurückgibt.  Sie sieht aus wie eine
      normale Funktion, mit der Ausnahme, dass Werte zum Aufrufenden mittels
      einer :keyword:`yield`-Anweisung statt mit einer
      :keyword:`return`-Anweisung zurückgegeben werden.  Generator-Funktionen
      enthalten oft eine oder mehrere Schleifen (:keyword:`for` oder
      :keyword:`while`), die dem Aufrufenden Elemente liefern
      (:keyword:`yield`en).  Die Ausführung der Funktion wird nach dem
      :keyword:`yield` unterbrochen (während das Ergebnis zurückgegeben wird)
      und wird dort wiederaufgenommen, wenn das nächste Element durch den Aufruf
      der :meth:`next`-Methode des zurückgegebenen Iterators angefordert wird.

   virtual machine
      Ein Computer, der komplett in Software definiert ist. Pythons Virtuelle
      Maschine führt den :term:`bytecode` aus, den der Bytecode-Compiler
      erzeugt.
