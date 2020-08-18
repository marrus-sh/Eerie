/*
#  Eerie  #
👂👁 A RegExp‐based IRI parser

___

Copyright (C) 2018 Kyebego

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

The GNU General Public License is available online at
<https://www.gnu.org/licenses/>.

___

##  Usage:

Simply pass the `RFC3987()` constructor an IRI.

    var iri = new RFC3987("http://📙.la/👀");
*/
"use strict";

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _unsupportedIterableToArray(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _iterableToArrayLimit(arr, i) { if (typeof Symbol === "undefined" || !(Symbol.iterator in Object(arr))) return; var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _unsupportedIterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method."); }

function _unsupportedIterableToArray(o, minLen) { if (!o) return; if (typeof o === "string") return _arrayLikeToArray(o, minLen); var n = Object.prototype.toString.call(o).slice(8, -1); if (n === "Object" && o.constructor) n = o.constructor.name; if (n === "Map" || n === "Set") return Array.from(o); if (n === "Arguments" || /^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n)) return _arrayLikeToArray(o, minLen); }

function _iterableToArray(iter) { if (typeof Symbol !== "undefined" && Symbol.iterator in Object(iter)) return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) return _arrayLikeToArray(arr); }

function _arrayLikeToArray(arr, len) { if (len == null || len > arr.length) len = arr.length; for (var i = 0, arr2 = new Array(len); i < len; i++) { arr2[i] = arr[i]; } return arr2; }

(function () {
  var _RFC, globalObject, iriRegex, regex, relativeRegex, _splitPath;

  iriRegex = RegExp("^(([A-Za-z][A-Za-z0-9+\\-\\.]*):(//((?:((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:]|%[0-9A-Fa-f]{2})*)@)?((\\[((?:[0-9A-Fa-f]{1,4}:){6}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|::(?:[0-9A-Fa-f]{1,4}:){5}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){4}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){3}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){2}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:)(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}(?:(?:[0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})?::)|(v[0-9A-Fa-f]+\\.[0-9A-Za-z\\-\\._~!\\$&'()*+,;=:]+)\\])|((?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=]|%[0-9A-Fa-f]{2})*))(?::(\\d*))?)((?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|(/(?:(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})+(?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)?)|((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})+(?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|())(?:\\?((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@\\uE000-\\uF8FF\\u{F0000}-\\u{FFFFD}\\u{100000}-\\u{10FFFD}/?]|%[0-9A-Fa-f]{2})*))?)(?:".concat("#", "((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*))?$"), "u");
  relativeRegex = RegExp("^(//((?:((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:]|%[0-9A-Fa-f]{2})*)@)?((\\[((?:[0-9A-Fa-f]{1,4}:){6}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|::(?:[0-9A-Fa-f]{1,4}:){5}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){4}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){3}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){2}(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:)(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|(?:(?:[0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}(?:(?:[0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})?::)|(v[0-9A-Fa-f]+\\.[0-9A-Za-z\\-\\._~!\\$&'()*+,;=:]+)\\])|((?:(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])\\.){3}(?:\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5]))|((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=]|%[0-9A-Fa-f]{2})*))(?::(\\d*))?)((?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|(/(?:(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})+(?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)?)|((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=@]|%[0-9A-Fa-f]{2})+(?:/(?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|())(?:\\?((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@\\uE000-\\uF8FF\\u{F0000}-\\u{FFFFD}\\u{100000}-\\u{10FFFD}/?]|%[0-9A-Fa-f]{2})*))?(?:".concat("#", "((?:[0-9A-Za-z\\-\\._~\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF\\u{10000}-\\u{1FFFD}\\u{20000}-\\u{2FFFD}\\u{30000}-\\u{3FFFD}\\u{40000}-\\u{4FFFD}\\u{50000}-\\u{5FFFD}\\u{60000}-\\u{6FFFD}\\u{70000}-\\u{7FFFD}\\u{80000}-\\u{8FFFD}\\u{90000}-\\u{9FFFD}\\u{A0000}-\\u{AFFFD}\\u{B0000}-\\u{BFFFD}\\u{C0000}-\\u{CFFFD}\\u{D0000}-\\u{DFFFD}\\u{E0000}-\\u{EFFFD}!\\$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*))?$"), "u");
  regex = new RegExp("(?:".concat(iriRegex.source, ")|(?:").concat(relativeRegex.source, ")"), "u");

  _splitPath = function splitPath(path) {
    var end, start;

    if (path == null) {
      return [];
    }

    if (path instanceof Array) {
      return Array.prototype.reduce.call(path, function (result, current) {
        result.push.apply(result, _toConsumableArray(_splitPath(current)));
        return result;
      }, []);
    } else {
      path = path.toString();
      start = path.search(/[^\/]/);
      end = path.search(/[^\/]\/*$/) + 1;

      if (start === -1 || end === -1) {
        return [];
      }

      return String.prototype.split.call(path.substring(start, end), "/");
    }
  };

  _RFC = function RFC3987(iri, relative) {
    var IPLiteral, IPv4address, IPv6address, IPvFuture, IRI, absoluteIRI, error, i, iauthority, ifragment, ihierPart, ihost, index, ipathAbempty, ipathAbsolute, ipathEmpty, ipathNoscheme, ipathRootless, iquery, iregName, irelativePart, irelativeRef, iuserinfo, len, match, part, parts, port, ref, result, scheme;

    if (relative === true) {
      error = "Relative IRI not well-formed under RFC3987.";
    } else if (relative === false) {
      error = "IRI not well-formed under RFC3987.";
    } else {
      error = "IRI reference not well-formed under RFC3987.";
    }

    if (iri == null) {
      throw new TypeError(error);
    }

    if (relative !== true && (match = String.prototype.match.call(iri, iriRegex))) {
      var _match = match;

      var _match2 = _slicedToArray(_match, 19);

      IRI = _match2[0];
      absoluteIRI = _match2[1];
      scheme = _match2[2];
      ihierPart = _match2[3];
      iauthority = _match2[4];
      iuserinfo = _match2[5];
      ihost = _match2[6];
      IPLiteral = _match2[7];
      IPv6address = _match2[8];
      IPvFuture = _match2[9];
      IPv4address = _match2[10];
      iregName = _match2[11];
      port = _match2[12];
      ipathAbempty = _match2[13];
      ipathAbsolute = _match2[14];
      ipathRootless = _match2[15];
      ipathEmpty = _match2[16];
      iquery = _match2[17];
      ifragment = _match2[18];
    } else if (relative !== false && (match = String.prototype.match.call(iri, relativeRegex))) {
      var _match3 = match;

      var _match4 = _slicedToArray(_match3, 17);

      irelativeRef = _match4[0];
      irelativePart = _match4[1];
      iauthority = _match4[2];
      iuserinfo = _match4[3];
      ihost = _match4[4];
      IPLiteral = _match4[5];
      IPv6address = _match4[6];
      IPvFuture = _match4[7];
      IPv4address = _match4[8];
      iregName = _match4[9];
      port = _match4[10];
      ipathAbempty = _match4[11];
      ipathAbsolute = _match4[12];
      ipathNoscheme = _match4[13];
      ipathEmpty = _match4[14];
      iquery = _match4[15];
      ifragment = _match4[16];
    } else {
      throw new TypeError(error);
    }

    result = this instanceof _RFC ? this : Object.create(_RFC.prototype);
    Object.defineProperties(result, {
      iri: {
        value: IRI
      },
      absolute: {
        value: absoluteIRI
      },
      relative: {
        value: irelativeRef
      },
      scheme: {
        value: scheme
      },
      hierarchicalPart: {
        value: ihierPart != null ? ihierPart : irelativePart
      },
      authority: {
        value: iauthority
      },
      userinfo: {
        value: iuserinfo
      },
      host: {
        value: ihost
      },
      port: {
        value: port
      },
      path: {
        value: (ref = ipathAbempty != null ? ipathAbempty : ipathAbsolute) != null ? ref : ipathRootless != null ? ipathRootless : ipathNoscheme != null ? ipathNoscheme : ipathEmpty
      },
      query: {
        value: iquery
      },
      fragment: {
        value: ifragment
      }
    });
    parts = _splitPath(ihierPart != null ? ihierPart : irelativePart);

    for (index = i = 0, len = parts.length; i < len; index = ++i) {
      part = parts[index];
      Object.defineProperty(result, index, {
        enumerable: true,
        value: part
      });
    }

    return Object.defineProperty(result, "length", {
      value: parts.length
    });
  };

  Object.defineProperty(_RFC, "prototype", {
    writable: false,
    value: Object.defineProperties({}, {
      constructor: {
        value: _RFC
      },
      toString: {
        value: function value() {
          var ref, ref1, value;

          if (!this) {
            return "";
          }

          if (typeof ((ref = value = (ref1 = this.iri) != null ? ref1 : this.relative) != null ? ref.toString : void 0) === "function") {
            return value.toString();
          } else {
            return "";
          }
        }
      },
      valueOf: {
        value: function value() {
          var iri, ref, ref1, ref2;

          if (!this) {
            return "";
          }

          if (typeof URL === "function") {
            try {
              return new URL((ref = this.iri) != null ? ref : this.relative);
            } catch (error1) {}
          }

          if (typeof ((ref1 = iri = (ref2 = this.iri) != null ? ref2 : this.relative) != null ? ref1.toString : void 0) === "function") {
            return iri.toString();
          } else if (typeof this.toString === "function") {
            return this.toString();
          } else {
            return "";
          }
        }
      }
    }, Object.defineProperties(_RFC, {
      iriRegex: {
        enumerable: true,
        value: regex
      },
      relativeRegex: {
        enumerable: true,
        value: regex
      },
      regex: {
        enumerable: true,
        value: regex
      },
      test: {
        enumerable: true,
        value: function value(iri, relative) {
          return (relative === true ? relativeRegex : relative === false ? iriRegex : regex).test(iri);
        }
      },
      testǃ: {
        enumerable: true,
        value: function value(iri, relative) {
          if (!(relative === true ? relativeRegex : relative === false ? iriRegex : regex).test(iri)) {
            throw new TypeError("IRI not well-formed according to RFC3987.");
          }
        }
      }
    }))
  });
  globalObject = typeof self !== "undefined" && self !== null ? self : typeof window !== "undefined" && window !== null ? window : typeof exports !== "undefined" && exports !== null ? exports : typeof global !== "undefined" && global !== null ? global : null;

  if (globalObject == null) {
    throw new ReferenceError("Unknown global object.");
  }

  (function () {
    var EAR, EYE;
    EAR = "\uD83D\uDC42";
    EYE = "\uD83D\uDC41";
    return Object.defineProperties(globalObject, _defineProperty({
      RFC3987: {
        configurable: true,
        value: _RFC
      }
    }, "".concat(EAR).concat(EYE), {
      configurable: true,
      value: _RFC
    }));
  })();

  Object.defineProperties(_RFC, {
    ℹ: {
      value: "https://go.KIBI.family/Eerie/"
    },
    Nº: {
      value: Object.freeze({
        major: 1,
        minor: 0,
        patch: 1,
        toString: function toString() {
          return "".concat(this.major, ".").concat(this.minor, ".").concat(this.patch);
        },
        valueOf: function valueOf() {
          return this.major * 100 + this.minor + this.patch / 100;
        }
      })
    },
    context: {
      writable: true,
      value: typeof self !== "undefined" && self !== null ? self : typeof window !== "undefined" && window !== null ? window : {}
    }
  });
}).call(void 0);
