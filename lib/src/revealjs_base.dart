/// Simple wrapping of API.
/// Based on the [API](https://github.com/hakimel/reveal.js#api), 17 Aug 2017
@JS('Reveal')
library revealjs;

import 'dart:html' show Event;
import 'package:js/js.dart';

@JS()
external initialize(InitializeParameters params);

// Navigation
@JS()
external dynamic slide(int indexh, [int indexv, int indexf]);

@JS()
external dynamic left();

@JS()
external dynamic right();

@JS()
external dynamic up();

@JS()
external dynamic down();

@JS()
external dynamic prevFragment();

@JS()
external dynamic nextFragment();

// Randomize the order of slides
@JS()
external void shuffle();

// Toggle presentation states, optionally pass true/false to force on/off
@JS()
external dynamic toggleOverview();
@JS()
external dynamic togglePause();
@JS()
external dynamic toggleAutoSlide();

// Shows a help overlay with keyboard shortcuts, optionally pass true/false
// to force on/off
@JS()
external dynamic toggleHelp();

// Change a config value at runtime
@JS()
external dynamic configure({controls: true});

// Returns the present configuration options
@JS()
external dynamic getConfig();

// Fetch the current scale of the presentation
@JS()
external dynamic getScale();

// Retrieves the previous and current slide elements
@JS()
external dynamic getPreviousSlide();
@JS()
external dynamic getCurrentSlide();

@JS()
external dynamic getIndices(); // { h: 0, v: 0 } }
@JS()
external dynamic getPastSlideCount();
@JS()
external dynamic getProgress(); // (0 == first slide, 1 == last slide)
@JS()
external dynamic getSlides(); // Array of all slides
@JS()
external dynamic getTotalSlides(); // total number of slides

// Returns the speaker notes for the current slide
@JS()
external dynamic getSlideNotes();

// State checks
@JS()
external dynamic isFirstSlide();
@JS()
external dynamic isLastSlide();
@JS()
external dynamic isOverview();
@JS()
external dynamic isPaused();
@JS()
external dynamic isAutoSliding();

@JS()
@anonymous
class InitializeParameters {
  external factory InitializeParameters();

  external MathParameters get math;
  external void set math(MathParameters math);

  external bool get controls;
  external void set controls(bool controls);

  external bool get progress;
  external void set progress(bool progress);

  external int get defaultTiming;
  external void set defaultTiming(int defaultTiming);

  external bool get slideNumber;
  external void set slideNumber(bool slideNumber);

  external bool get history;
  external void set history(bool history);

  external bool get keyboard;
  external void set keyboard(bool keyboard);

  external bool get overview;
  external void set overview(bool overview);

  external bool get center;
  external void set center(bool center);

  external bool get touch;
  external void set touch(bool touch);

  external bool get loop;
  external void set loop(bool loop);

  external bool get rtl;
  external void set rtl(bool rtl);

  external bool get shuffle;
  external void set shuffle(bool shuffle);

  external bool get fragments;
  external void set fragments(bool fragments);

  external bool get embedded;
  external void set embedded(bool embedded);

  external bool get help;
  external void set help(bool help);

  external bool get showNotes;
  external void set showNotes(bool showNotes);

  external bool get autoPlayMedia;
  external void set autoPlayMedia(bool autoPlayMedia);

  external int get autoSlide;
  external void set autoSlide(int autoSlide);

  external bool get autoSlideStoppable;
  external void set autoSlideStoppable(bool autoSlideStoppable);

  external dynamic get autoSlideMethod;
  external void set autoSlideMethod(dynamic autoSlideMethod);

  external bool get mouseWheel;
  external void set mouseWheel(bool mouseWheel);

  external bool get hideAddressBar;
  external void set hideAddressBar(bool hideAddressBar);

  external bool get previewLinks;
  external void set previewLinks(bool previewLinks);

  external String get transition;
  external void set transition(String transition);

  external String get transitionSpeed;
  external void set transitionSpeed(String transitionSpeed);

  external String get backgroundTransition;
  external void set backgroundTransition(String backgroundTransition);

  external int get viewDistance;
  external void set viewDistance(int viewDistance);

  external String get parallaxBackgroundImage;
  external void set parallaxBackgroundImage(String parallaxBackgroundImage);

  external String get parallaxBackgroundSize;
  external void set parallaxBackgroundSize(String parallaxBackgroundSize);

  external int get parallaxBackgroundHorizontal;
  external void set parallaxBackgroundHorizontal(int parallaxBackgroundHorizontal);

  external int get parallaxBackgroundVertical;
  external void set parallaxBackgroundVertical(int parallaxBackgroundVertical);

  external String get display;
  external void set display(String display);

  external List<DependencyParameters> get dependencies;
  external void set dependencies(List<DependencyParameters> dependencies);
}

@JS()
@anonymous
class DependencyParameters {
  external factory DependencyParameters();

  external String get src;
  external void set src(String src);

  external bool get async;
  external void set async(bool async);

  external Function get condition;
  external void set condition(Function condition);

  external Function get callback;
  external void set callback(Function callback);
}

@JS()
@anonymous
class MathParameters {
  external factory MathParameters();
  external String get mathjax;
  external void set mathjax(String mathjax);

  external String get config;
  external void set config(String config);
}

typedef void EventCallback(Event event);

/// See revealjs/events.dart for stream interfaces
@JS()
external void addEventListener(
    String state, EventCallback callback, bool useCapture);

/// See revealjs/events.dart for stream interfaces
@JS()
external void removeEventListener(
    String state, EventCallback callback, bool useCapture);

@JS()
external dynamic getState();

@JS()
external void setState(dynamic state);

@JS()
external bool isReady();
