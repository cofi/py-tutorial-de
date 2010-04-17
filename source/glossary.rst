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
      bereitgestellt.  Siehe :ref:`2to3-reference`.

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

   classic class
      Jede Klasse, die nicht von :class:`object` erbt. Siehe :term:`new-style
      class`. Classic classes werden in Python 3.0 entfernt.

   coercion
      Die implizite Konvertierung eines Exemplares eines Typs in einen anderen
      während einer Operation, die zwei Argumente desselben Typs erfordert.  Zum
      Beispiel konvertiert ``int(3.15)`` die Fliesskomma-Zahl zu der Ganzzahl
      ``3``, aber in ``3 + 4.5`` ist jedes Argument von einem verschiedenen Typ
      (eines *int*, eines *float*) und beide müssen zum selben Typ konvertiert
      werden oder es wird ein :exc:`TypeError` erzeugt. Coercion zwischen zwei
      Operanden, kann mit der eingebauten Funktion :func:`coerce` ausgeführt
      werden; so ist ``3 + 4.5`` äquivalent zum Aufruf ``operator.add(*coerce(3,
      4.5))`` und resultiert in ``operator.add(3.0, 4.5)``.  Ohne Coercion
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

      Siehe :ref:`the documentation for function definition <function>` zu mehr
      über Dekoratoren.

   descriptor
      Jedes *new-style* Objekt, das die Methoden :meth:`__get__`,
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
      :ref:`descriptors`.

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
      sind nicht alle Sprachkonstrukte Ausdrücke. Es gibt ebenfalls Anweisungen
      (:term:`statement`), die nicht als als Ausdruck benutzt werden können, wie
      :keyword:`print` oder :keyword:`if`. Zuweisungen sind ebenfalls
      Anweisungen, keine Ausdrücke.

   extension module
      Ein Modul, das in C oder C++ geschrieben ist und mit Pythons C API mit dem
      Kern und dem Benutzer-Code zusammenarbeitet.

   finder
      Ein Objekt, das versucht den :term:`loader` für ein Modul zu finden. Es
      muss eine Methode namens :meth:`find_module` implementieren.

      Siehe :pep:`302` für Details.

   function
      Eine Serie von Anweisungen, die einen Wert zum Aufrufenden zurückgeben.
      Ihr können ebenfalls null oder mehr Argumente übergeben werden, die in der
      Ausführung des Rumpfs benutzt werden können.

      Siehe auch :term:`argument` und :term:`method`.

   __future__
      Ein Pseudo-Modul, das Programmierern ermöglicht neue Sprach-Features zu
      aktivieren, die nicht kompatibel mit dem aktuellen Interpreter sind.  Zum
      Beispiel evaluiert der Ausdruck ``11/4`` momentan zu  ``2``. Hätte das
      Modul, in dem er ausgeführt wird *echte Division* durch folgendes
      aktiviert::

          from __future__ import division

      dann würde der Ausdruck ``11/4`` zu ``2.75`` evaluieren. Durch den Import
      des :mod:`__future__`-Moduls und dem Auswerten seiner Variablen, kann man
      sehen, wann ein Feature zuerst der Sprache hinzugefügt wurde und wann es
      das Standard-Verhalten wird::

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
      der :meth:`next`-Methode des zurückgegebenen Iterators angefordert wird.

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
      :meth:`__eq__`- oder :meth:`__cmp__`-Methode). Hashbare Objekte, die sich
      gleichen, müssen denselben Hashwert haben.

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

   integer division
      Mathematische Division, die jeden Rest verwirft.  Zum Beispiel,
      evaluatiert der Ausdruck ``11 / 4`` zur Zeit zu ``2`` im Unterschied zu
      ``2.75``, das von der Fliesskomma-Division zurückgegebenen wird.  Auch
      *floor division* genannt.  Bei der Teilung von zwei Ganzzahlen wird das
      Ergebnis immer eine Ganzzahl sein (auf die :func:`math.floor` angewendet
      wurde).  Ist einer der Operanden von einem anderen numerischen Typ (wie
      :class:`float`), werden beide auf den gemeinsamen Typ gezwungen (siehe
      :term:`coercion`).  Zum Beispiel resultiert eine Ganzzahl geteilt durch
      eine Fliesskomma-Zahl in einer Fliesskomma-Zahl, möglicherweise mit einem
      Deziamalrest.  Ganzzahl-Division kann mit dem ``//``-Operator anstelle des
      ``/``-Operators erzwungen werden.  Siehe auch :term:`__future__`.

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
      :meth:`next`-Methode geben die aufeinanderfolgenden Elemente im Datenstrom
      zurück. Sind keine Daten mehr vorhanden, wird eine
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

      Mehr Informationen können bei :ref:`typeiter` gefunden werden.

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
      Look before you leap.  ("Schau bevor du springst.")  Dieser
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
      einem :term:`finder` zurückgegebenen.  Siehe :pep:`302` für Details.

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

      Mehr Informationen können in :ref:`metaclasses` gefunden werden.

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
      :func:`__builtin__.open` und :func:`os.open` anhand ihres Namensraumes
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
      Jede Klasse, die von :class:`object` erbt.  Dies schliesst alle
      eingebauten Typen wie :class:`list` und :class:`dict` ein.  Nur new-style
      Klassen können Pythons neuere, vielseitige Features wie
      :attr:`__slots__`, Deskriptoren, Properties und :meth:`__getattribute__`
      benutzen.

      Mehr Informationen können bei :ref:`newstyle` gefunden werden.

   object
      Alle Daten mit Zustand (Attribute oder Wert) und definiertem Verhalten
      (Methoden).  Ebenfalls die ultimative Basisklasse von jeder
      :term:`new-style`-Klasse.

   virtual machine
      Ein Computer, der komplett in Software definiert ist.  Pythons Virtuelle
      Maschine führt den :term:`bytecode` aus, den der Bytecode-Compiler
      erzeugt. 
