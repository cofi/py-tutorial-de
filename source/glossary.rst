.. _glossary: 

*******
Glossar
*******

.. glossary::

   ``>>>``
      Der Standard-Prompt der interaktiven Python-Shell.  Man begegnet ihm oft
      in Code-Beispielen die interaktiv im Interpreter ausgeführt werden können.

   ``...``
      Der Standard-Prompt der interaktiven Shell, wenn man Code für einen
      eingerückten Code-Block oder innerhalb eines Paars passender Klammern
      (rund, eckig oder geschweift) eingibt.

   2to3
      Ein Werkzeug, das versucht Python 2.x Code zu Python 3.x Code zu
      konvertieren, indem es die meisten Inkompabilitäten, die durch das Parsen
      der Quellen und das traversieren des Parse-Baumes erkannt werden können,
      behandelt.

      2to3 ist in der Standardbibliothek als :mod:`lib2to3` verfügbar.  Ein
      eigenständiger Einstiegspunkt ist als :file:`Tools/scripts/2to3`
      bereitgestellt.  Siehe :lib:`2to3 - Automated Python 2 to 3 code
      translation <2to3.html#to3-reference>`.

   abstract base class
      Abstrakte Basisklassen (Abstract Base Classes - kurz ABCs) ergänzen
      :term:`duck-typing`, indem sie das definieren von Schnittstellen
      ermöglichen, wo andere Techniken wie :func:`hasattr` umständlich wären.
      Python kommt mit vielen eingebauten ABCs für Datenstrukturen (im
      :mod:`collections`-Modul), Zahlen (im :mod:`numbers`-Modul) und Ströme (im
      :mod:`io`-Modul).  Man kann eigene ABC mit dem :mod:`abc`-Modul erzeugen.

   argument
      Ein Wert, der einer Funktion oder Methode übergeben wird und einer
      benannten lokalen Variable im Funktionsrumpf zugewiesen wird.  Eine
      Funktion oder Methode kann sowohl Positions-, als auch
      Schlüsselwort-Argumente in ihrer Definition haben. Positions- und
      Schlüsselwort-Argumente können von variabler Länge sein: ``*`` akzeptiert
      (falls in der Funktionsdefinition) oder übergibt  (im Funktionsaufruf)
      mehrere Positionsargumente in einer Liste, während ``**`` dasselbe für
      Schlüsselwort-Argumente in einem Dictionary leistet.

      Jeder Ausdruck kann innerhalb der Argumentliste benutzt werden und der
      ausgewertete Wert wird an die lokale Variable übergeben.

   attribute
      Ein Wert, der mit einem Objekt assoziiert ist, wird von einem Namen
      mittels Punkt-Ausdruck referenziert.  Zum Beispiel, hätte ein Objekt *o*
      ein Attribut *a*, so würde es als *o.a* referenziert.

   BDFL
      Benevolent Dictator For Life (Wohlwollender Diktator auf Lebenszeit), auch
      bekannt als `Guido van Rossum <http://www.python.org/~guido/>`_, der
      Schöpfer von Python.

   bytecode
      Die interne Darstellung eines Python-Programmes im Interpreter,
      Python-Programme werden zu ihm kompiliert.  Der Bytecode wird in ``.pyc``-
      und ``.pyo``-Dateien gespeichert, so dass das Ausführen derselben Datei
      beim zweiten Mal schneller ist (da die erneute Kompilierung zu Bytecode
      vermieden werden kann).  Diese "Zwischensprache" (*intermediate language*)
      ist dazu gedacht auf einer :term:`virtual machine` (Virtuellen Maschine)
      ausgeführt zu werden, die den Maschinencode zum jeweiligen Bytecode
      ausführt.

   class
      Eine Vorlage für die Erstellung benutzerdefinierter Objekte.
      Klassendefinitionen enthalten normalerweise Methodendefinitionen, die auf
      den Exemplaren der Klasse agieren.

   coercion
      Die implizite Konvertierung eines Exemplares eines Typs in einen anderen
      während einer Operation, die zwei Argumente desselben Typs erfordert.  Zum
      Beispiel konvertiert ``int(3.15)`` die Fliesskomma-Zahl zu der Ganzzahl
      ``3``, aber in ``3 + 4.5`` ist jedes Argument von einem verschiedenen Typ
      (eines *int*, eines *float*) und beide müssen zum selben Typ konvertiert
      werden oder es wird ein :exc:`TypeError` erzeugt. Ohne Coercion
      müssten alle Argumente, selbst von kompatiblen Typen, zum selben Typ
      vom Programmierer normalisiert werden, z.B. ``float(3) + 4.5`` statt nur
      ``3 + 4.5``.

   complex number
      Eine Erweiterung zum bekannten reellen Zahlensystem, in dem alle Zahlen
      als eine Summe eines reellen Anteils und eines imaginären Anteils
      ausgedrückt werden.  Imaginäre Zahlen sind echte Vielfache der imaginären
      Einheit (der Wurzel von ``-1``), oft in der Mathematik oft als *i* oder im
      Ingenieurwesen als *j* geschrieben. Python hat eingebaute Unterstützung
      für Komplexe Zahlen, die mit folgender Notation geschrieben werden: Der
      imaginäre Anteil wird mit dem Suffix *j* geschrieben, z.B. ``3+1j``. Um
      Zugang zu den komplexen Äquivalenten des :mod:`math`-Modules zu bekommen,
      benutzt man :mod:`cmath`.  Der Gebrauch von Komplexen Zahlen ist ein recht
      fortgeschrittenes mathematisches Werkzeug.  Kennt man keine Notwendigkeit
      sie zu benutzen, ist es fast sicher, dass man sie getrost ignorieren kann.

   context manager
      Ein Objekt, das die Umgebung, der man in einer :keyword:`with`-Anweisung
      begegnet, kontrolliert, indem es die Methoden :meth:`__enter__` und
      :meth:`__exit__` definiert.
      Siehe :pep:`343`.

   CPython
      Die kanonische Implementierung der Pyton Programmiersprache.  Der Term
      "CPython" wird in Kontexten benutzt, in denen es nötig ist diese
      Implementierung von anderen wie Jython oder IronPython zu unterscheiden.

   decorator
      Eine Funktion, die eine andere Funktion zurückgibt, normalerweise als
      Funktionstransformation durch die ``@wrapper``-Syntax benutzt.  Häufige
      Beispiele für Dekoratoren sind :func:`classmethod` und
      :func:`staticmethod`.
      
      Die Dekorator-Syntax ist nur Syntaktischer Zucker (syntactic sugar). Die
      beiden folgenden Definitionen sind semantisch äquivalent::

         def f(...):
             ...
         f = staticmethod(f)

         @staticmethod
         def f(...):
             ...

      Dasselbe Konzept existiert für Klassen, ist jedoch dort weniger
      gebräuchlich.  Siehe die Dokumentation für :reff:`Funktionsdefinitionen
      <compound_stmts.html#function>` und :reff:`Klassendefinitionen
      <compound_stmts.html#class>` für mehr über Dekoratoren.

   descriptor
      Jedes Objekt, das die Methoden :meth:`__get__`,
      :meth:`__set__` oder :meth:`__delete__` definiert. Wenn ein
      Klassenattribut ein Deskriptor ist, wird sein spezielles Bindeverhalten
      beim Attributs-Lookup ausgelöst.  Wenn man *a.b* für das Abfragen (*get*),
      Setzen (*set*) oder Löschen (*delete*) eines Attributs benutzt, wird nach
      einem Objekt namens *b* im Klassendictionary von *a* gesucht, ist *b* aber
      ein Deskriptor, wird die jeweilige Deskriptor-Methode aufgerufen. Das
      Verstehen von Deskriptoren ist wichtig für ein tiefes Verständnis von
      Python, da sie die Basis für viele Features einschliesslich Funtionen,
      Methoden, Properties, Klassenmethoden, statische Methoden und Referenzen
      zu Super-Klassen bilden.
      
      Für mehr Informationen zu den Deskriptor-Methoden, siehe
      :reff:`Implementing Descriptors <datamodel.html#descriptors>`.

   dictionary
      Ein assoziatives Array, wo beliebige Schlüssel auf Werte abgebildet
      werden.  Die Benutzung von :class:`dict` kommt der von :class:`list` sehr
      nahe, aber ein Schlüssel kann jedes Objekt sein, das eine
      :meth:`__hash__`-Methode hat, nicht nur Ganzzahlen.
      Trägt den Namen *hash* in Perl.

   docstring
      Ein Stringliteral, das als erster Ausdruck in einer Klasse, Funktion oder
      einem Modul vorkommt.  Während es beim Ausführen der Suite ignoriert wird,
      erkennt der Compiler es und weist es dem :attr:`__doc__`-Attribut der
      umgebenden Klasse, Funktion oder Modul zu.  Da es durch Introspektion
      verfügbar ist, ist es der kanonische Ort für Dokumentation des Objekts.

   duck-typing
      Ein pythonischer Programmierstil, der den Typ eines Objektes anhand seiner
      Methoden- oder Attributssignatur bestimmt, statt durch die explizite
      Zuordnung zu einem Typ-Objekt. ("Sieht es wie eines Ente aus und quakt es
      wie eine Ente, dann muss es eine Ente sein.") Durch die Hervorhebung von
      Schnittstellen statt spezifischer Typen, verbessert ein gut-durchdachter
      Code seine Flexibilität, indem er polymorphe Substitution
      zulässt. Duck-typing vermeidet Tests mittels :func:`type` oder
      :func:`isinstance`. (Beachte jedoch, dass duck-typing durch Abstrakte
      Basis Klassen ergänzt werden kann.) Stattdessen benutzt es Tests mit
      :func:`hasattr` oder :term:`EAFP`-Programmierung.

   EAFP
      "Easier to ask for forgiveness than permission." (Leichter um
      Vergebung zu bitten, als um Erlaubnis.)  Dieser geläufige
      Python-Programmierstil setzt die Existenz von validen Schlüsseln oder
      Attributen voraus und fängt Ausnahmen ab, wenn die Voraussetzung nicht
      erfüllt wurde.  Für diesen sauberen und schnellen Stil ist die Präsenz
      vieler :keyword:`try`- und :keyword:`except`-Anweisungen
      charakteristisch.  Diese Technik hebt sich von dem :term:`LBYL`-Stil ab,
      der in vielen anderen Sprachen wie beispielsweise C geläufig ist.

   expression
      Ein Stück Syntax, die zu einem Wert evaluiert werden kann.  Mit anderen
      Worten ist ein Ausdruck eine Anhäufung von Ausdruckselementen wie
      Literale, Namen, Attributszugriffe, Operatoren oder Funktionsaufrufen, die
      alle einen Wert zurückgeben. Im Unterschied zu vielen anderen Sprachen,
      sind nicht alle Sprachkonstrukte Ausdrücke.  Es gibt ebenfalls Anweisungen
      (:term:`statement`), die nicht als als Ausdruck benutzt werden können, wie
      etwa :keyword:`if`.  Zuweisungen sind ebenfalls Anweisungen, keine
      Ausdrücke.

   extension module
      Ein Modul, das in C oder C++ geschrieben ist und mit Pythons C API mit dem
      Kern und dem Benutzer-Code zusammenarbeitet.

   finder
      Ein Objekt, das versucht den :term:`loader` für ein Modul zu finden. Es
      muss eine Methode namens :meth:`find_module` implementieren.

      Siehe :pep:`302` für Details und :class:`importlib.abc.Finder` für eine
      :term:`abstract base class`.

   floor division
      Mathematische Division die jeden Rest verwirft.  Der Operator für
      Ganzzahl-Division ist ``//``.  Zum Beispiel evaluatiert der Ausdruck
      ``11//4``  zu ``2`` im Gegensatz zu ``2.75``, die von Fliesskomma-Division
      zurückgegeben wird.

   function
      Eine Serie von Anweisungen, die einen Wert zum Aufrufenden zurückgeben.
      Ihr können ebenfalls null oder mehr Argumente übergeben werden, die in der
      Ausführung des Rumpfs benutzt werden können.

      Siehe auch :term:`argument` und :term:`method`.

   __future__
      Ein Pseudo-Modul, das Programmierern ermöglicht neue Sprach-Features zu
      aktivieren, die nicht kompatibel mit dem aktuellen Interpreter sind.

      Durch den Import des :mod:`__future__`-Moduls und dem Auswerten seiner
      Variablen, kann man sehen, wann ein Feature zuerst der Sprache hinzugefügt
      wurde und wann es das Standard-Verhalten wird::

          >>> import __future__
          >>> __future__.division
          _Feature((2, 2, 0, 'alpha', 2), (3, 0, 0, 'alpha', 0), 8192)

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
      (:keyword:`yield` en).  Die Ausführung der Funktion wird nach dem
      :keyword:`yield` unterbrochen (während das Ergebnis zurückgegeben wird)
      und wird dort wiederaufgenommen, wenn das nächste Element durch den Aufruf
      der :meth:`__next__`-Methode des zurückgegebenen Iterators angefordert wird.

      .. index:: single: generator expression

   generator expression
      Ein Ausdruck, der einen Generator zurückgibt. Er sieht wie ein normaler
      Ausdruck aus, gefolgt von einem :keyword:`for`-Ausdruck, der eine
      Schleifenvariable - hier *range* - definiert und einem optionalem
      :keyword:`if`-Ausdruck. Der kombinierte Ausdruck generiert Werte für eine
      umgebende Funktion::

         >>> sum(i*i for i in range(10))         # summe der quadrate von 1,2, …, 10
         285

   GIL
      Siehe :term:`global interpreter lock`.

   global interpreter lock
      multi-processor machines.  Efforts have been made in the past to
      create a "free-threaded" interpreter (one which locks shared data at a
      much finer granularity), but so far none have been successful because
      performance suffered in the common single-processor case.

      Das Lock, das von Python-Threads benutzt wird, um sicherzustellen, dass
      nur ein Thread gleichzeitig in der Virtuellen Maschine (:term:`virtual
      machine`) von :term:`CPython` ausgeführt wird. Den ganzen Interpreter zu
      locken, macht es dem Interpreter einfacher multi-threaded zu sein, auf
      Kosten eines Großteils der Parallelität, die von Multi-Prozessor Maschinen
      bereitgestellt wird. In der Vergangenheit gab es viele Bestrebungen einen
      "free-threaded" Interpreter (der den Zugriff auf geteilte Daten in einer
      feineren Granularität blockt) zu erschaffen, jedoch war noch keiner
      erfolgreich, da alle Performance-Einbußen im häufigen Fall des
      Einzel-Prozessors.

   hashable
      Ein Objekt ist *hashbar*, wenn es einen Hashwert hat, der sich niemals
      während seiner Existenz ändert (es braucht eine :meth:`__hash__`-Methode)
      und mit anderen Objekten verglichen werden kann (es braucht eine
      :meth:`__eq__`-Methode). Hashbare Objekte, die sich gleichen, müssen
      denselben Hashwert haben.

      Hashbarkeit macht ein Objekt als Dictionary-Schlüssel und als
      Mengen-Mitglied benutzbar, da diese Datenstrukturen intern den Hashwert
      benutzen.

      Alle von Pythons eingebauten, unveränderbaren Objekte sind hashbar,
      während keiner der veränderbaren Container (wie Listen oder Dictionaries)
      es ist. Objekte, die Exemplare von benutzerdefinierten Klassen sind, sind
      standardmäßig hashbar; sie vergleichen auf ungleich und ihr Hashwert ist
      ihre :func:`id`.

   IDLE
      Eine IDE (Integrated Development Environment) für Python.  IDLE ist eine
      einfache Editor- und Interpreter-Umgebung, die in der
      Standard-Distribution von Python enthalten ist.  Gut für Anfänger geeignet
      und dient auch als Beispiel-Code für alle, die eine moderat komplexe,
      Multi-Plattform GUI Anwendung erstellen wollen.

   immutable
      Ein Objekt mit einem festen Wert.  Zu den unveränderbaren (*immutable*)
      Objekten zählen Zahlen, Strings und Tupel.  Solche Objekte könnnen nicht
      verändert werden. Ein neues Objekte muss erzeugt werden, wenn ein
      verschiedener Wert gespeichert werden muss.  Sie spielen eine wichtige
      Rolle an Stellen, bei denen ein konstanter Hashwert benötigt wird, zum
      Beispiel als Schlüssel in einem Dictionary.

   importer
      Ein Objekt, das sowohl Module fundet und lädt; zugleich ein
      :term:`finder`- und :term:`loader`-Objekt.

   interactive
      Python hat einen interaktiven Interpreter. Das bedeutet, dass man
      Anweisungen und Ausdrücke in den Interpreter-Prompt eingeben kann, die
      sofort ausgeführt werden und deren Ergebnis man sehen kann.  Man startet
      einfach ``python`` ohne Argumente (möglicherweise indem man es im
      Hauptmenü des Computers auswählt).  Es ist ein mächtiger Weg, um neue
      Ideen zu testen oder Module und Pakete zu untersuchen (``help(x)`` ist
      hilfreich).

   interpreted
      Python ist eine interpretierte Sprache, im Gegensatz zu einer
      kompilierten, obwohl die Unterscheidung aufgrund des Bytecode-Compilers
      verschwommen ist.  Das heisst, dass Quelldateien direkt ausgeführt werden
      können ohne explizit eine ausführbare Datei zu erstellen, die dann
      ausgeführt wird.  Interpretierte Sprachen haben typischerweise einen
      kürzeren Entwicklungs/Debug-Zyklus als kompilierte, jedoch laufen deren
      Programme generell etwas langsamer.  Siehe auch :term:`interactive`.

   iterable
      Ein Container-Objekt, das dazu imstande ist seine Mitglieder nacheinander
      zurückzugeben.  Beispiele von Iterables sind alle Sequenztypen (wie etwa
      :class:`list`, :class:`str` und :class:`tuple`) und einige
      nicht-Sequenztypen wie :class:`dict` und :class:`file` und Objekte, die
      man mit :meth:`__iter__`- oder :meth:`__getitem__`-Methoden definiert.
      Iterables können in :keyword:`for`-Schleifen und vielen anderen Stellen
      verwendet werden, wo eine Sequenz benötigt wird (:func:`zip`, :func:`map`,
      etc.).  Wird ein Iterable als Argument der eingebauten Funktion
      :func:`iter` übergeben, gibt sie einen Iterator für dieses Objekt zurück.
      Dieser Iterator ist gut, für einen Durchlauf über die Menge der Werte.
      Nutzt man Iterables, ist es meist nicht nötig :func:`iter` aufzurufen oder
      sich mit Iterator-Objekten direkt zu befassen.  Die
      :keyword:`for`-Anweisung erledigt das automatisch, indem sie eine
      temporäre unbenannte Variable erstellt, um den Iterator für die Laufzeit
      der Schleife zu halten.  Siehe auch :term:`iterator`, :term:`sequence` und
      :term:`generator`.

   iterator
      Ein Objekt, das einen Datenstrom repräsentiert.  Wiederholte Aufrufe der
      :meth:`__next__`-Methode des Iterators oder die Übergabe an die eingebaute
      Funktion :func:`next` geben die aufeinanderfolgenden Elemente im
      Datenstrom zurück. Sind keine Daten mehr vorhanden, wird eine
      :exc:`StopIteration`-Ausnahme ausgelöst.  An dieser Stelle ist das
      Iterator-Objekt erschöpft und alle weiteren Aufrufe verursachen nur
      weitere :exc:`StopIteration`.  Iteratoren müssen ebenfallse eine
      :meth:`__iter__`-Methode haben, die den Iterator selbst zurückgibt, sodass
      jeder Iterator selbst ein Iterable ist und in den meisten Fällen benutzt
      werden kann, wo andere Iterables akzeptiert werden.  Eine wichtige
      Ausnahme ist Code, der mehrere Iterationen versucht.  Ein Container-Objekt
      (wie etwa :class:`list`) erzeugt jedes Mal einen neuen Iterator, wenn man
      es der :func:`iter`-Funktion übergibt oder in einer
      :keyword:`for`-Schleife benutzt.  Versucht man dies mit einem Iterator,
      wird nur dasselbe erschöpfte Iterator-Objekt zurückgeben, das schon im
      vorangegangenen Durchlauf benutzt wurde und es so wie einen leeren
      Container erscheinen lässt.

      Mehr Informationen können bei :lib:`Iterator Types
      <stdtypes.html#typeiter>` gefunden werden.

   keyword argument
      Argumente, denen ein ``variable_name=`` im Aufruf vorausgeht.  Der
      Variablenname bestimmt den lokalen Namen der Funktion, dem der Wert
      zugewiesen wird.  ``**`` wird benutzt um ein Dictionary von
      Schlüsselwort-Argumenten zu übergeben oder zu akzeptieren.  Siehe
      :term:`argument`.

   lambda
      Eine anonyme inline Funktion, die nur aus einem einzelnen Ausdruck
      (:term:`expression`) besteht, der ausgewertet wird, wenn die Funktion
      aufgerufen wird. Die Syntax, um eine lambda-Funktion zu erstellen ist
      ``lambda [arguments]: expression``.

   LBYL
      "Look before you leap."  ("Schau bevor du springst.")  Dieser
      Programmierstil testet explizit auf Vorbedingungen bevor Aufrufe oder
      Lookups getätigt werden.  Dieser Stil steht dem :term:`EAFP` Ansatz
      gegenüber und die Präsenz vieler :keyword:`if`-Anweisungen ist
      charakteristisch für ihn.

   list
      Eine eingebaute Python :term:`sequence`.  Trotz des Namens ist sie
      ähnlicher zu Arrays in anderen Sprachen als zu Verknüpften Listen (*linked
      lists*), da der Elementzugriff in O(1) ist.

   list comprehension
      Ein kompakter Weg, um alle oder Teile der Elemente in einer
      Sequenz verarbeitet und eine Liste der Ergebnisse zurückgibt.  ``result =
      ["0x%02x" % x for x in range(256) if x % 2 == 0]`` generiert eine Liste
      von Strings, die die geraden Hex-Zahlen (0x..) im Bereich von 0 bis 255
      enthält.  Der :keyword:`if`-Abschnitt ist optional.  Wird er ausgelassen,
      werden alle Elemente von ``range(256)`` verarbeitet.

   loader
      Ein Objekt, das ein Modul lädt.  Es muss eine Methode namens
      :meth:`load_module` definieren.  Ein *loader* wird typischerweise von
      einem :term:`finder` zurückgegebenen.  Siehe :pep:`302` für Details und
      :class:`importlib.abc.Loader` für eine :term:`abstract base class`.

   mapping
      Ein Container-Objekt (wie etwa :class:`dict`), das beliebige
      Schlüssel-Lookups mittels der speziellen Methode :meth:`__getitem`
      unterstützt.

   metaclass
      Die Klasse einer Klasse. Klassendefinitionen erstellen einen Klassennamen,
      ein Klassendictionary und eine Liste der Basisklassen.  Eine Metaklasse
      ist dafür verantwortlich diese drei Argumente entgegen zunehmen und
      Klassen zu erzeugen.  Die meisten Objektorientierten Programmiersprachen
      bieten eine Standard-Implementierung.  Was Python speziell macht, ist dass
      es möglich ist eigene Metaklassen zu erstellen.  Die meisten Benutzer
      benötigen dieses Werkzeug nicht, kommt das Bedürfnis aber auf, können
      Metaklassen mächtige und elegante Lösungen bieten.  Sie wurden schon
      benutzt um Attributszugriffe zu loggen, Thread-Sicherheit hinzuzufügen,
      Objekterzeugung zu verfolgen, Singletons zu implementieren und für viele
      andere Aufgaben.

      Mehr Informationen können in :reff:`Customizing class creation
      <datamodel.html#metaclasses>` gefunden werden.

   method
      Eine Funktion, die innerhalb eines Klassenkörpers definiert wurde.  Wird
      es als Attribut eines Exemplares dieser Klasse aufgerufen, bekommt die
      Methode das Exemplar-Objekt als ihr erstes Argument (:term:`argument`)
      (das normalerweise ``self`` genannt wird).
      Siehe :term:`function` und :term:`nested scope`.

   mutable
      Veränderliche (*mutable*) Objekte können ihren Wert ändern, aber ihre
      :func:`id` behalten.  Siehe auch :term:`immutable`

   named tuple
      Jede Tupel-ähnliche Klasse, deren indizierbaren Elemente auch über
      benannte Attribute zugänglich sind (zum Beispiel gibt
      :func:`time.localtime` ein Tupel-ähnliches Objekt zurück, wo das Jahr
      sowohl durch einen Index, wie ``t[0]``, als auch durch ein benanntes
      Attribut wie ``t.tm_year`` zugänglich ist).

      Ein benanntes Tupel kann ein eingebauter Typ wie etwa
      :class:`time.struct_time` sein oder es kann mit einer regulären
      Klassendefinition erstellt werden.  Ein voll funktionierendes benanntes
      Tupel kann auch mit der Factory-Funktion :func:`collections.namedtuple`
      erstellt werden.  Der zweite Ansatz bietet automatische extra Features wie
      eine selbst-dokumentierende Repräsentation wie ``Employee(name='jones',
      title='programmer')``.

   namespace
      Der Ort, an dem eine Variable gespeichert wird.  Namensräume sind als
      Dictionaries implementiert.  Es gibt lokale, globale und eingebaute
      Namensräume, wie auch verschachtelte Namensräume in Objekten (in
      Methoden).  Namensräume unterstützen Modularität, indem sie
      Namenskonflikten vorbeugen.  Zum Beispiel werden die Funktionen
      :func:`builtins.open` und :func:`os.open` anhand ihres Namensraumes
      unterschieden.  Namensräume unterstützen außerdem die Lesbarkeit und
      Wartbarkeit indem sie klar machen, welches Modul eine Funktion
      implementiert. Zum Beispiel machen :func:`random.seed` oder
      :func:`itertools.izip` es klar, dass diese Funktionen in den Modulen
      :mod:`random` beziehungsweise :mod:`itertools` implementiert werden.

   nested scope
      Die Fähigkeit eine Variable in einer umgebenden Definition zu
      referenzieren. Zum Beispiel, kann eine Funktion, die in einer anderen
      Funktion definiert wird auf die Variablen in der äußeren Funktion
      zugreifen.  Beachte, dass verschachtelte Gültigkeitsbereiche nur bei
      Referenzierungen, nicht bei Zuweisungen, die immer in den innersten
      Gültigkeitsbereich schreiben, funktionieren.  Im Gegensatz dazu lesen und
      schreiben lokale Variablen in den innersten Gültigkeitsbereich.
      Gleichfalls, lesen und schreiben globale Variablen in den globalen
      Namensraum.

   new-style class
      Alter Name für die Sorte von Klassen, die nun für alle Klassenobjekte
      benutzt wird.  In früheren Versionen von Python, konnten nur new-style
      Klassen Pythons neuere vielseitige Features wie :attr:`__slots__`,
      Deskriptoren, Properties und :meth:`__getattribute__` benutzen.

   object
      Alle Daten mit Zustand (Attribute oder Wert) und definiertem Verhalten
      (Methoden).  Ebenfalls die ultimative Basisklasse von jeder
      :term:`new-style class`.

   positional argument
      Die Argumente, die lokalen Namen innerhalb einer Funktion oder Methode
      zugewiesen werden, die von der Reihenfolge in der sie im Aufruf angegeben
      werden festgelegt sind.  ``*`` wird benutzt um entweder mehrere
      Positionsargumente entgegenzunehmen (wenn es in der Definition vorkommt)
      oder um mehrere Argumente als eine Liste einer Funktion zu übergeben.
      Siehe :term:`argument`.

   Python 3000
      Spitzname für die Reihe der Veröffentlichungen in Python 3.x (geprägt vor
      langer Zeit, als die Veröffentlichung von Version 3 etwas in ferner
      Zukunft war.)  Dies wird auch als "Py3k" abgekürzt.

   Pythonic
      Eine Idee oder Stück von Code, der den häufigsten Idiomen der
      Python-Sprache eng folgt, statt Konzepte zu verwenden, die häufig in
      anderen Sprachen vorkommen.  Zum Beispiel ist es ein häufiges Idiom in
      Python über alle Elemente eines Iterable mithilfe einer
      :keyword:`for`-Anweisung zu iterieren.  Viele andere Sprachen haben nicht
      diese Art von Konstrukt, sodass Leute, die mit Python nicht vertraut sind
      manchmal einen numerischen Zähler benutzen::

          for i in range(len(food)):
              print(food[i])

      Im Gegensatz zum sauberen, pythonischen Weg::

         for piece in food:
             print(piece)

   reference count
      Die Anzahl von Referenzen zu einem Objekt.  Fällt der Referenzzähler eines
      Objekts auf null, wird es dealloziert.  Das Referenzzählen ist generell
      nicht sichtbar für Python-Code, ist jedoch ein Schlüsselelement der
      :term:`CPython` Implementierung.  Das Modul :mod:`sys` definiert eine
      :func:`getrefcount`-Funktion, die Programmierer aufrufen können, um den
      Referenzzähler für ein bestimmtes Objekt zu bekommen.

   __slots__
      Eine Deklaration innerhalb einer Klasse, die Speicher spart, indem der
      Platz für Instanzattribute vorher deklariert wird und Exemplardictionaries
      eliminiert werden.  Auch wenn sie populär sind, ist es trickreich die
      Technik richtig anzuwenden und sollte am besten für seltene Fälle
      aufgehoben werden, wenn es große Zahlen von Exemplaren in einer
      speicherkritischen Anwendung gibt.

   sequence
      Ein Iterable (:term:`iterable`), das effizienten Elementzugriff mit
      Ganzzahlindizes durch die spezielle Methode :meth:`__getitem__` bietet und
      eine :meth:`__len__`-Methode definiert, die die Länge der Sequenz
      zurückgibt.  Manche eingebauten Sequenztypen sind :class:`list`,
      :class:`str`, :class:`tuple` und :class:`bytes`.  Beachte, dass
      :class:`dict` ebenfalls :meth:`__getitem__` und :meth:`__len__` definiert,
      aber eher als Mapping (:term:`mapping`), denn als Sequenz angesehen, da
      die Lookups durch beliebige unveränderbare (:term:`immutable`) Schlüssel
      möglich sind, nicht nur durch Ganzzahlen.

   slice
      Ein Objekt, das normalerweise einen Abschnitt einer Sequenz
      (:term:`sequence`) enthält.  Ein Slice wird mittels der
      Subskript-Notation, ``[]`` mit Doppelpunkten zwischen Nummern, wenn
      mehrere gegeben werden, wie in ``variable_name[1:3:5]``.  Die Notation mit
      eckigen Klammern (Subskript-Notation) benutzt :class:`slice`-Objekte
      intern.

   special method
      Eine Methode die implizit von Python aufgerufen wird, um eine bestimmte
      Operation auf einem Typ auszuführen, wie etwa Addition.  Solche Methoden
      haben Namen mit führenden wie abschliessenden doppelten Unterstrichen.
      Spezielle Methoden sind bei :reff:`Special method names
      <datamodel.html#specialnames>` dokumentiert.

   statement
      Eine Anweisung ist Teil einer Suite (ein "Block" von Code).  Eine
      Anweisung ist entweder ein Ausdruck (:term:`expression`) oder eine von
      mehreren Konstrukten mit einem Schlüsselwort, wie etwa :keyword:`if`,
      :keyword:`while` oder :keyword:`for`.

   triple-quoted string
      Ein String, der von entweder drei Anführungszeichen (") oder Apostrophen
      (') umgeben ist.  Während sie keine Funktionalität bieten, die nicht bei
      einfach-quotierten Strings verfügbar wären, sind sie aus mehreren Gründen
      nützlich.  Sie erlauben das Einbeziehen von unmaskierten Anführungszeichen
      und Apostrophen innerhalb eines Strings und sie können mehrere Zeilen
      umfassen ohne das Fortsetzungszeichen benutzen zu müssen, was sie
      besonders nützlich beim Schreiben von Docstrings macht.

   type
      Der Typ eines Python-Objektes legt fest, welche Art von Objekt es ist;
      jedes Objekt hat einen Typ.  Der Typ eines Objektes ist als dessen
      :attr:`__class__`-Attribut zugänglich oder kann mit ``type(obj)`` bestimmt
      werden.
 
   view
      Die Objekte, die von :meth:`dict.keys`, :meth:`dict.values` und
      :meth:`dict.items` zurückgegeben werden, werden Dictionary-Views genannt.
      Sie sind Lazy Sequenzen, die Veränderungen im zugrundeliegenden Dictionary
      bemerken. Um einen Dictionary-View zu zwingen eine volle Liste zu werden,
      benutzt man ``list(dictview)``. Siehe :lib:`Dictionary view objects
      <stdtypes.html#dict-views>`.

   virtual machine
      Ein Computer, der komplett in Software definiert ist.  Pythons Virtuelle
      Maschine führt den :term:`bytecode` aus, den der Bytecode-Compiler
      erzeugt. 

   Zen of Python
      Aufzählung von Pythons Design Prizipien und Philosophien, die hilfreich
      beim verstehen und benutzen der Sprache sind.  Gibt man "``import this``"
      am interaktiven Prompt ein, kann man die Aufzählung einsehen.
