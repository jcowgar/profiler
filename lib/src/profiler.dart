import 'section.dart';

class Profiler {
  final Map<String, Section> _sections;
  final List<String> _nestedSections;
  final List<String> _sectionOrder;

  String _currentSectionName;

  Profiler()
      : _sections = {},
        _nestedSections = [],
        _sectionOrder = [];

  void act() {
    _sections[_currentSectionName].act();
  }

  void begin(String sectionName) {
    if (_currentSectionName != null) {
      _sections[_currentSectionName].stop();
    }

    if (!_sections.containsKey(sectionName)) {
      _sections[sectionName] = Section(sectionName);
      _sectionOrder.add(sectionName);
    }

    _currentSectionName = sectionName;
    _sections[sectionName].start();
  }

  void end() {
    _sections[_currentSectionName].stop();
  }

  void push(String sectionName) {
    _nestedSections.add(sectionName);

    begin(sectionName);
  }

  void pop() {
    final sectionName = _nestedSections.removeLast();

    _sections[sectionName].stop();

    if (_nestedSections.isNotEmpty) {
      begin(_nestedSections.last);
    }
  }

  Future<void> profile(String sectionName, dynamic code()) async {
    push(sectionName);
    try {
      final result = code();
      if (result is Future) {
        await result;
      }
      act();
    } finally {
      pop();
    }
  }

  Iterable<Section> report() => _sectionOrder.map((s) => _sections[s]);
}
