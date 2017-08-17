import 'package:revealjs/revealjs.dart';
import 'package:revealjs/dependencies.dart';

void main() {
  // if demo.html was in the `example` directoy the default pathToPackages would
  // suffice. Either will likely work when using pub serve, but might give
  // unexpected results when built using pub build.
  var dependencies = [
    classListParams,
    markedParams,
    markdownParams,
    highlightParams,
    zoomJsParams,
    notesParams
  ].map((f) => f('../packages')).toList();
  // var dependencies = [];
  initialize(new InitializeParameters()
    ..controls = true
    ..progress = true
    ..history = true
    ..center = true
    ..transition = 'slide'
    ..dependencies = dependencies);

  // dart stream interfaces
  onReady.then((_) => 'ready to go!');
  onSlideChange.listen((notifier) =>
      print('Now on slide (${notifier.indexv}, ${notifier.indexh})'));
  onFragmentShow.listen(
      (notifier) => print('${notifier.fragments.length} fragments shown'));
  onFragmentHide.listen(
      (notifier) => print('${notifier.fragments.length} fragments hidden'));
  onStateChange('hello-state')
      .listen((notifier) => print('Now in the \'hello-there\' state'));
}
