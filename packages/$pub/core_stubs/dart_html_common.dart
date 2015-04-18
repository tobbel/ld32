library html_common; import 'dart:collection'; import "dart_html.dart"; import 'metadata.dart'; export 'metadata.dart';  abstract class CssClassSetImpl implements CssClassSet { String toString() { throw new UnsupportedError("CssClassSetImpl.toString() is unsupported on this platform."); }   bool toggle(String value, [bool shouldAdd]) { throw new UnsupportedError("CssClassSetImpl.toggle() is unsupported on this platform."); }   bool get frozen { throw new UnsupportedError("CssClassSetImpl.frozen is unsupported on this platform."); }   Iterator<String> get iterator { throw new UnsupportedError("CssClassSetImpl.iterator is unsupported on this platform."); }   void forEach(void f(String element)) { throw new UnsupportedError("CssClassSetImpl.forEach() is unsupported on this platform."); }   String join([String separator = ""]) { throw new UnsupportedError("CssClassSetImpl.join() is unsupported on this platform."); }   Iterable map(f(String element)) { throw new UnsupportedError("CssClassSetImpl.map() is unsupported on this platform."); }   Iterable<String> where(bool f(String element)) { throw new UnsupportedError("CssClassSetImpl.where() is unsupported on this platform."); }   Iterable expand(Iterable f(String element)) { throw new UnsupportedError("CssClassSetImpl.expand() is unsupported on this platform."); }   bool every(bool f(String element)) { throw new UnsupportedError("CssClassSetImpl.every() is unsupported on this platform."); }   bool any(bool f(String element)) { throw new UnsupportedError("CssClassSetImpl.any() is unsupported on this platform."); }   bool get isEmpty { throw new UnsupportedError("CssClassSetImpl.isEmpty is unsupported on this platform."); }   bool get isNotEmpty { throw new UnsupportedError("CssClassSetImpl.isNotEmpty is unsupported on this platform."); }   int get length { throw new UnsupportedError("CssClassSetImpl.length is unsupported on this platform."); }   String reduce(String combine(String value, String element)) { throw new UnsupportedError("CssClassSetImpl.reduce() is unsupported on this platform."); }   dynamic fold(dynamic initialValue, dynamic combine(dynamic previousValue, String element)) { throw new UnsupportedError("CssClassSetImpl.fold() is unsupported on this platform."); }   bool contains(Object value) { throw new UnsupportedError("CssClassSetImpl.contains() is unsupported on this platform."); }   String lookup(Object value) { throw new UnsupportedError("CssClassSetImpl.lookup() is unsupported on this platform."); }   bool add(String value) { throw new UnsupportedError("CssClassSetImpl.add() is unsupported on this platform."); }   bool remove(Object value) { throw new UnsupportedError("CssClassSetImpl.remove() is unsupported on this platform."); }   void addAll(Iterable<String> iterable) { throw new UnsupportedError("CssClassSetImpl.addAll() is unsupported on this platform."); }   void removeAll(Iterable<Object> iterable) { throw new UnsupportedError("CssClassSetImpl.removeAll() is unsupported on this platform."); }   void toggleAll(Iterable<String> iterable, [bool shouldAdd]) { throw new UnsupportedError("CssClassSetImpl.toggleAll() is unsupported on this platform."); }   void retainAll(Iterable<Object> iterable) { throw new UnsupportedError("CssClassSetImpl.retainAll() is unsupported on this platform."); }   void removeWhere(bool test(String name)) { throw new UnsupportedError("CssClassSetImpl.removeWhere() is unsupported on this platform."); }   void retainWhere(bool test(String name)) { throw new UnsupportedError("CssClassSetImpl.retainWhere() is unsupported on this platform."); }   bool containsAll(Iterable<Object> collection) { throw new UnsupportedError("CssClassSetImpl.containsAll() is unsupported on this platform."); }   Set<String> intersection(Set<Object> other) { throw new UnsupportedError("CssClassSetImpl.intersection() is unsupported on this platform."); }   Set<String> union(Set<String> other) { throw new UnsupportedError("CssClassSetImpl.union() is unsupported on this platform."); }   Set<String> difference(Set<String> other) { throw new UnsupportedError("CssClassSetImpl.difference() is unsupported on this platform."); }   String get first { throw new UnsupportedError("CssClassSetImpl.first is unsupported on this platform."); }   String get last { throw new UnsupportedError("CssClassSetImpl.last is unsupported on this platform."); }   String get single { throw new UnsupportedError("CssClassSetImpl.single is unsupported on this platform."); }   List<String> toList({bool growable : true}) { throw new UnsupportedError("CssClassSetImpl.toList() is unsupported on this platform."); }   Set<String> toSet() { throw new UnsupportedError("CssClassSetImpl.toSet() is unsupported on this platform."); }   Iterable<String> take(int n) { throw new UnsupportedError("CssClassSetImpl.take() is unsupported on this platform."); }   Iterable<String> takeWhile(bool test(String value)) { throw new UnsupportedError("CssClassSetImpl.takeWhile() is unsupported on this platform."); }   Iterable<String> skip(int n) { throw new UnsupportedError("CssClassSetImpl.skip() is unsupported on this platform."); }   Iterable<String> skipWhile(bool test(String value)) { throw new UnsupportedError("CssClassSetImpl.skipWhile() is unsupported on this platform."); }   String firstWhere(bool test(String value), {String orElse()}) { throw new UnsupportedError("CssClassSetImpl.firstWhere() is unsupported on this platform."); }   String lastWhere(bool test(String value), {String orElse()}) { throw new UnsupportedError("CssClassSetImpl.lastWhere() is unsupported on this platform."); }   String singleWhere(bool test(String value)) { throw new UnsupportedError("CssClassSetImpl.singleWhere() is unsupported on this platform."); }   String elementAt(int index) { throw new UnsupportedError("CssClassSetImpl.elementAt() is unsupported on this platform."); }   void clear() { throw new UnsupportedError("CssClassSetImpl.clear() is unsupported on this platform."); }   modify(f(Set<String> s)) { throw new UnsupportedError("CssClassSetImpl.modify() is unsupported on this platform."); }   Set<String> readClasses();   void writeClasses(Set<String> s); }  class Device {             static String get userAgent { throw new UnsupportedError("Device.userAgent is unsupported on this platform."); }   static bool get isOpera { throw new UnsupportedError("Device.isOpera is unsupported on this platform."); }   static bool get isIE { throw new UnsupportedError("Device.isIE is unsupported on this platform."); }   static bool get isFirefox { throw new UnsupportedError("Device.isFirefox is unsupported on this platform."); }   static bool get isWebKit { throw new UnsupportedError("Device.isWebKit is unsupported on this platform."); }   static String get cssPrefix { throw new UnsupportedError("Device.cssPrefix is unsupported on this platform."); }   static String get propertyPrefix { throw new UnsupportedError("Device.propertyPrefix is unsupported on this platform."); }   static bool isEventTypeSupported(String eventType) { throw new UnsupportedError("Device.isEventTypeSupported() is unsupported on this platform."); } }  class FilteredElementList<T extends Element> extends ListBase<T> implements NodeListWrapper {     FilteredElementList(Node node) { throw new UnsupportedError("new FilteredElementList() is unsupported on this platform."); }    void forEach(void f(T element)) {}   void operator []=(int index, T value) {}   void set length(int newLength) {}   void add(T value) {}   void addAll(Iterable<T> iterable) {}   bool contains(Object needle) {}   Iterable<T> get reversed {}   void sort([int compare(T a, T b)]) {}   void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {}   void fillRange(int start, int end, [T fillValue]) {}   void replaceRange(int start, int end, Iterable<T> iterable) {}   void removeRange(int start, int end) {}   void clear() {}   T removeLast() {}   void insert(int index, T value) {}   void insertAll(int index, Iterable<T> iterable) {}   T removeAt(int index) {}   bool remove(Object element) {}   int get length {}   T operator [](int index) {}   Iterator<T> get iterator {}   List<Node> get rawList {} }  class Lists { static int indexOf(List a, Object element, int startIndex, int endIndex) { throw new UnsupportedError("Lists.indexOf() is unsupported on this platform."); }   static int lastIndexOf(List a, Object element, int startIndex) { throw new UnsupportedError("Lists.lastIndexOf() is unsupported on this platform."); }   static List getRange(List a, int start, int end, List accumulator) { throw new UnsupportedError("Lists.getRange() is unsupported on this platform."); } } abstract class NodeListWrapper { List<Node> get rawList; }