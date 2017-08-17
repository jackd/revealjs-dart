# revealjs-dart

A basic wrapper library for [reveal.js](https://github.com/hakimel/reveal.js/) slide presentation framework.

## Usage

### Running the demo

```
pub serve example
```
Navigate to `localhost:8080/demo/demo.html`

### Example usage
See below/[demo](https://github.com/jackd/revealjs-dart/example/demo) for example usage.

In html:

    <script src="packages/revealjs/reveal.js/js/head.js"></script>
    <script src="packages/revealjs/reveal.js/js/reveal.js"></script>

    <script type="application/dart" src="my_awesome_slides.dart"></script>
    <script src="packages/browser/dart.js"></script>

In 'my_awesome_slides.dart':

    import 'package:revealjs/revealjs.dart';
    import 'package:revealjs/dependencies.dart';

    void main() {
      var dependencies = [
        classListParams(),
        markedParams(),
        markdownParams(),
        highlightParams(),
        zoomJsParams(),
        notesParams()
      ]
      // var dependencies = [];
      initialize(new InitializeParameters()
        ..controls = true
        ..progress = true
        ..history = true
        ..center = true
        ..transition = 'slide'
        ..dependencies = dependencies);

      // dart stream interfaces
      onReady.then((_) => 'reveal.js ready to go!');
      onSlideChange.listen((notifier) =>
        print('Now on slide (${notifier.indexv}, ${notifier.indexh})'));
      onFragmentShow.listen(
        (notifier) => print('${notifier.fragments.length} fragments shown'));
      onFragmentHide.listen(
        (notifier) => print('${notifier.fragments.length} fragments hidden'));
      onStateChange('hello-state')
        .listen((notifier) => print('Now in the \'hello-there\' state'));
    }

See the [reveal.js](https://github.com/hakimel/reveal.js/).
