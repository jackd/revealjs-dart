/**
 * Common dependencies used by [initialize]. packagesPath is normaly the
 * relative path from the html file in which the call is made to the
 * web/packages directory. Note that an incorrect path may result in correct
 * behaviour using pub serve but could give incorrect behaviour when deploying
 * the output of pub serve.
 */
import 'dart:html';
import 'dart:js';
import 'package:js/js.dart';
import 'package:revealjs/revealjs.dart';
import 'package:revealjs/highlightjs.dart';

DependencyParameters classListParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src = [packagesPath, '/revealjs/reveal.js/lib/js/classList.js'].join()
      ..condition = allowInterop(() =>
          !new JsObject.fromBrowserObject(document.body)
              .hasProperty('classList'));

DependencyParameters markedParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src =
          [packagesPath, '/revealjs/reveal.js/plugin/markdown/marked.js'].join()
      ..condition =
          allowInterop(() => document.querySelector('[data-markdown]') != null);

DependencyParameters markdownParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src = [packagesPath, '/revealjs/reveal.js/plugin/markdown/markdown.js']
          .join()
      ..condition =
          allowInterop(() => document.querySelector('[data-markdown]') != null);

DependencyParameters highlightParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src = [
        packagesPath,
        '/revealjs/reveal.js/plugin/highlight/highlight.js'
      ].join()
      ..callback = allowInterop(() => initHighlightingOnLoad());

DependencyParameters zoomJsParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src =
          [packagesPath, '/revealjs/reveal.js/plugin/zoom-js/zoom.js'].join()
      ..async = true;

DependencyParameters notesParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src = [packagesPath, '/revealjs/reveal.js/plugin/notes/notes.js'].join()
      ..async = true;

DependencyParameters mathParams([String packagesPath = 'packages']) =>
    new DependencyParameters()
      ..src = [packagesPath, '/revealjs/reveal.js/plugin/math/math.js'].join()
      ..async = true;
