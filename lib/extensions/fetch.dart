import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_js/javascript_runtime.dart';
import './xhr.dart';

var _fetchDebug = false;

setFetchDebug(bool value) => _fetchDebug = value;

extension JavascriptRuntimeFetchExtension on JavascriptRuntime {
  Future<JavascriptRuntime> enableFetch({required XhrInterceptor xhrInterceptor, String? fetchPolyfill}) async {
    debug('Before enable xhr');
    enableXhr(xhrInterceptor: xhrInterceptor);
    debug('After enable xhr');
    fetchPolyfill ??= await getFetchPolyfill();
    debug('Loaded fetchPolyfill');
    final evalFetchResult = evaluate(fetchPolyfill);
    debug('Eval Fetch Result: $evalFetchResult');
    return this;
  }

  static Future<String> getFetchPolyfill() async {
    return await rootBundle.loadString('packages/flutter_js/assets/js/fetch.js');
  }
}

void debug(String message) {
  if (_fetchDebug) {
    print('JavascriptRuntimeFetchExtension: $message');
  }
}
