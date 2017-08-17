/***
 * Events exposed by reveal.addEventListener converted to [Stream] interfaces.
 *
 * Each function/getter creates a non-broadcast [Stream] backed by it's own
 * [StreamController]. Users are responsible for closing the [StreamController]
 * by cancelling subscriptions to avoid memory leaks.
 *
 * Wrappers:
 * reveal type  -> [Stream] function
 * slidechanged -> [onSlideChange]
 * fragmentshown -> [onFragmentShow]
 * fragmenthidden -> [onFragmentHide]
 * ready -> [onReady] (future, see also [isReady])
 * {{state}} -> [onStateChange](state)
 * {{type}} -> [onEvent](type) (catch all - prefer to use the above).
 */
import 'dart:html' show Event, HtmlElement;
import 'dart:async';
import 'dart:js';
import 'dart:collection' show UnmodifiableListView;
import 'package:js/js.dart';
import 'revealjs_base.dart';

Map<String, dynamic> _objectToKwargs(Object object) {
  var kwargs = <String, dynamic>{};
  context['Object']
      .callMethod('entries', [object]).forEach((kv) => kwargs[kv[0]] = kv[1]);
  return kwargs;
}

Stream<Event> _eventStream(String type) {
  EventCallback callback;
  var controller = new StreamController<Event>(
      onCancel: () => removeEventListener(type, callback, false));
  callback = allowInterop((event) => controller.add(event));
  addEventListener(type, callback, false);
  return controller.stream;
}

/// Abstract interface for the specific objects emmited by
/// reveal.addEventListener. [Event] data is provided by the [event] getter.
abstract class Notifier {
  bool get isTrusted;
  Event get event;
}

class _Notifier implements Notifier {
  final bool isTrusted;
  final Event event;
  const _Notifier.create(this.event, this.isTrusted);

  factory _Notifier(Event event) {
    var kwargs = _objectToKwargs(event);
    return new _Notifier.create(event, kwargs['isTrusted']);
  }
}

/***
 * Notification type for changing slides. See [onSlideChange].
 */
abstract class SlideChangeNotifier implements Notifier {
  int get indexh;
  int get indexv;
  HtmlElement get previousSlide;
  HtmlElement get currentSlide;
  bool get isTrusted;
  Event get event;
}

class _SlideChangeNotifier implements SlideChangeNotifier {
  final Event event;
  final bool isTrusted;
  final int indexh;
  final int indexv;
  final HtmlElement previousSlide;
  final HtmlElement currentSlide;
  final dynamic origin;

  factory _SlideChangeNotifier(event) {
    var kwargs = _objectToKwargs(event);
    return new _SlideChangeNotifier.create(
        event,
        kwargs['isTrusted'],
        kwargs['indexh'],
        kwargs['indexv'],
        kwargs['previousSlide'],
        kwargs['currentSlide'],
        kwargs['origin']);
  }

  _SlideChangeNotifier.create(this.event, this.isTrusted, this.indexh,
      this.indexv, this.previousSlide, this.currentSlide, this.origin);
}

/***
 * Notification class of Fragment hide/shows. See [onFragmentShow] and
 * [onFragmentHide]
 */
abstract class FragmentNotifier implements Notifier {
  HtmlElement get fragment;
  List<HtmlElement> get fragments;
  Event get event;
}

class _FragmentNotifier implements FragmentNotifier {
  final HtmlElement fragment;
  final UnmodifiableListView<HtmlElement> fragments;
  final Event event;
  final bool isTrusted;

  _FragmentNotifier.create(
      this.event, this.isTrusted, this.fragment, this.fragments);

  factory _FragmentNotifier(Event event) {
    var kwargs = _objectToKwargs(event);
    return new _FragmentNotifier.create(
        event,
        kwargs['isTrusted'],
        kwargs['fragment'],
        new UnmodifiableListView<HtmlElement>(kwargs['fragments']));
  }
}

/// [Stream] interface to reveal's 'slidechanged' event type
Stream<SlideChangeNotifier> get onSlideChange =>
    _eventStream('slidechanged').map((e) => new _SlideChangeNotifier(e));

/// [Stream] interface to reveal's 'fragmentshown' event type
Stream<FragmentNotifier> get onFragmentShow =>
    _eventStream('fragmentshown').map((e) => new _FragmentNotifier(e));

/// [Stream] interface to reveal's 'fragmenthidden' event type
Stream<FragmentNotifier> get onFragmentHide =>
    _eventStream('fragmenthidden').map((e) => new _FragmentNotifier(e));

/// Completes when reveal is ready. See [isReady] for synchronous check.
/// Linked to reveal's 'ready' event type.
Future<Null> get onReady => isReady()
    ? new Future<bool>.value(null)
    : onEvent('ready').first.then((_) => null);

/// Triggered on entering section with data-state='{{state}}' attribute.
/// Linked to reveal's event type of the specified state.
Stream<Notifier> onStateChange(String state) =>
    _eventStream(state).map((e) => new _Notifier(e));

/// Catch-all. Prefer to use [onStateChange], [onReady], [onFragmentShow],
/// [onFragmentHide] or [onSlideChange].
Stream<Notifier> onEvent(String type) =>
    _eventStream(type).map((e) => new _Notifier(e));
