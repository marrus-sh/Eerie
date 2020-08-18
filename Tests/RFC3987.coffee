{ expect } = require "chai"
{ RFC3987 } = require "../Build/Eerie.js"

describe "RFC3987", ->
  it "exists", ->
    expect RFC3987
      .a "function"

  describe "Identity", ->

    it "has the correct API ID", ->
      expect RFC3987
        .has.ownProperty "ℹ"
        .which.equals "https://go.KIBI.family/Eerie/"

    it "has the correct version", ->
      packageVersion = process.env.npm_package_version
      [ major, minor, patch ] = packageVersion.split "."
      expect RFC3987, "… numero"
        .has.ownProperty "Nº"
      expect RFC3987.Nº, "… major"
        .has.ownProperty "major"
        .which.equals +major
      expect RFC3987.Nº, "… minor"
        .has.ownProperty "minor"
        .which.equals +minor
      expect RFC3987.Nº, "… patch"
        .has.ownProperty "patch"
        .which.equals +patch
      expect "#{RFC3987.Nº}", "… string"
        .equals packageVersion
      expect +RFC3987.Nº, "… value"
        .equals +major * 100 + +minor + +patch / 100

    it "has a context", ->
      expect RFC3987
        .has.ownProperty "context"
        .a "object"

  describe "Constructor", ->

    it "can be called as a constructor", ->
      expect iri = new RFC3987 "example:iri"
        .instanceOf RFC3987
      expect (do iri.toString), "… to produce correct IRI"
        .equals "example:iri"

    it "can be called as a function", ->
      expect iri = new RFC3987 "example:iri"
        .instanceOf RFC3987
      expect (do iri.toString), "… to produce correct IRI"
        .equals "example:iri"

    it "only takes relative IRIs if second argument is true", ->
      expect iri = new RFC3987 "/foo", yes
        .instanceOf RFC3987
      expect (do iri.toString), "… to produce correct IRI"
        .equals "/foo"
      do expect -> tag = new RFC3987 "example:iri", yes
        .throws

    it "refuses relative IRIs if second argument is false", ->
      expect tag = new RFC3987 "example:iri", no
        .instanceOf RFC3987
      expect (do tag.toString), "… to produce correct IRI"
        .equals "example:iri"
      do expect -> tag = new RFC3987 "/foo", no
        .throws

    describe "Properties", ->

      it ".iriRegex", ->
        expect RFC3987
          .has.ownProperty "iriRegex"
          .instanceOf RegExp

      it ".relativeRegex", ->
        expect RFC3987
          .has.ownProperty "relativeRegex"
          .instanceOf RegExp

      it ".regex", ->
        expect RFC3987
          .has.ownProperty "regex"
          .instanceOf RegExp

    describe "Methods", ->

      it ".test()", ->
        expect RFC3987
          .has.ownProperty "test"
          .a "function"
        expect RFC3987.test "example:iri"
          .is.true
        expect RFC3987.test "example:iri", yes
          .is.false
        expect RFC3987.test "example:iri", no
          .is.true
        expect RFC3987.test "/foo"
          .is.true
        expect RFC3987.test "/foo", yes
          .is.true
        expect RFC3987.test "/foo", no
          .is.false
        expect RFC3987.test "%"
          .is.false

      it ".testǃ()", ->
        expect RFC3987
          .has.ownProperty "testǃ"
          .a "function"
        expect RFC3987.testǃ "example:iri"
          .is.undefined
        do expect -> RFC3987.testǃ "example:iri", yes
          .throws
        expect RFC3987.testǃ "example:iri", no
          .is.undefined
        expect RFC3987.testǃ "/foo"
          .is.undefined
        expect RFC3987.testǃ "/foo", yes
          .is.undefined
        do expect -> RFC3987.testǃ "/foo", no
          .throws
        do expect -> RFC3987.testǃ "%"
          .throws

  describe "Instances", ->

    it "is iterable", ->
      expect iri = new RFC3987 "example://0/1/2/3/4/5/"
        .instanceOf RFC3987
      continue for _, index in iri
      expect index
        .equals iri.length

    describe "Properties", ->  #  See later tests for part mapping

      it "[]", ->
        expect iri = new RFC3987 "example:0/1/2/3/4/5/"
          .instanceOf RFC3987
        expect iri
          .has.ownProperty i = 0
          .which.equals "0"
        expect iri
          .has.ownProperty ++i
          .which.equals "1"
        expect iri
          .has.ownProperty ++i
          .which.equals "2"
        expect iri
          .has.ownProperty ++i
          .which.equals "3"
        expect iri
          .has.ownProperty ++i
          .which.equals "4"
        expect iri
          .has.ownProperty ++i
          .which.equals "5"

      it ".length", ->
        expect iri = new RFC3987 "example:0/1/2/3/4/5/"
          .instanceOf RFC3987
        expect iri
          .has.ownProperty "length"
          .which.equals 6

      it "sets non-present parts to `undefined`", ->
        expect iri = new RFC3987 "example:iri"
          .instanceOf RFC3987
        expect iri
          .has.ownProperty "relative"
          .which.is.undefined
        expect iri
          .has.ownProperty "userinfo"
          .which.is.undefined
        expect iri
          .has.ownProperty "port"
          .which.is.undefined
        expect iri
          .has.ownProperty "query"
          .which.is.undefined
        expect iri
          .has.ownProperty "fragment"
          .which.is.undefined
        expect iri = new RFC3987 "/foo"
          .instanceOf RFC3987
        expect iri
          .has.ownProperty "iri"
          .which.is.undefined
        expect iri
          .has.ownProperty "absolute"
          .which.is.undefined
        expect iri
          .has.ownProperty "scheme"
          .which.is.undefined
        expect iri
          .has.ownProperty "authority"
          .which.is.undefined
        expect iri
          .has.ownProperty "userinfo"
          .which.is.undefined
        expect iri
          .has.ownProperty "host"
          .which.is.undefined
        expect iri
          .has.ownProperty "port"
          .which.is.undefined
        expect iri
          .has.ownProperty "query"
          .which.is.undefined
        expect iri
          .has.ownProperty "fragment"
          .which.is.undefined

    describe "Methods", ->

      it ".toString()", ->
        expect iri = new RFC3987 "example:iri"
          .instanceOf RFC3987
        expect do iri.toString
          .equals "example:iri"

      it ".valueOf()", ->
        expect iri = new RFC3987 "example:iri"
          .instanceOf RFC3987
        expect do iri.valueOf
          .instanceOf URL
        expect do (do iri.valueOf).toString
          .equals "example:iri"

  describe "IRI Tests", ->

    it "http://user:pass@foo:21/bar;par?b#c", ->
      expect iri = new RFC3987 "http://user:pass@foo:21/bar;par?b#c"
        .instanceOf RFC3987
      expect (Array.prototype.slice.call iri), "… has correct parts"
        .has.ordered.members [ "user:pass@foo:21", "bar;par" ]
      expect iri, "… has correct length"
        .has.ownProperty "length"
        .which.equals 2
      expect iri, "… has correct iri"
        .has.ownProperty "iri"
        .which.equals "http://user:pass@foo:21/bar;par?b#c"
      expect iri, "… has correct absolute"
        .has.ownProperty "absolute"
        .which.equals "http://user:pass@foo:21/bar;par?b"
      expect iri, "… has correct relative"
        .has.ownProperty "relative"
        .which.is.undefined
      expect iri, "… has correct scheme"
        .has.ownProperty "scheme"
        .which.equals "http"
      expect iri, "… has correct hierarchicalPart"
        .has.ownProperty "hierarchicalPart"
        .which.equals "//user:pass@foo:21/bar;par"
      expect iri, "… has correct authority"
        .has.ownProperty "authority"
        .which.equals "user:pass@foo:21"
      expect iri, "… has correct userinfo"
        .has.ownProperty "userinfo"
        .which.equals "user:pass"
      expect iri, "… has correct host"
        .has.ownProperty "host"
        .which.equals "foo"
      expect iri, "… has correct port"
        .has.ownProperty "port"
        .which.equals "21"
      expect iri, "… has correct path"
        .has.ownProperty "path"
        .which.equals "/bar;par"
      expect iri, "… has correct query"
        .has.ownProperty "query"
        .which.equals "b"
      expect iri, "… has correct fragment"
        .has.ownProperty "fragment"
        .which.equals "c"

    it "//user:pass@foo:21/file?b#c", ->
      expect iri = new RFC3987 "//user:pass@foo:21/bar;par?b#c"
        .instanceOf RFC3987
      expect (Array.prototype.slice.call iri), "… has correct parts"
        .has.ordered.members [ "user:pass@foo:21", "bar;par" ]
      expect iri, "… has correct length"
        .has.ownProperty "length"
        .which.equals 2
      expect iri, "… has correct iri"
        .has.ownProperty "iri"
        .which.is.undefined
      expect iri, "… has correct absolute"
        .has.ownProperty "absolute"
        .which.is.undefined
      expect iri, "… has correct relative"
        .has.ownProperty "relative"
        .which.equals "//user:pass@foo:21/bar;par?b#c"
      expect iri, "… has correct scheme"
        .has.ownProperty "scheme"
        .which.is.undefined
      expect iri, "… has correct hierarchicalPart"
        .has.ownProperty "hierarchicalPart"
        .which.equals "//user:pass@foo:21/bar;par"
      expect iri, "… has correct authority"
        .has.ownProperty "authority"
        .which.equals "user:pass@foo:21"
      expect iri, "… has correct userinfo"
        .has.ownProperty "userinfo"
        .which.equals "user:pass"
      expect iri, "… has correct host"
        .has.ownProperty "host"
        .which.equals "foo"
      expect iri, "… has correct port"
        .has.ownProperty "port"
        .which.equals "21"
      expect iri, "… has correct path"
        .has.ownProperty "path"
        .which.equals "/bar;par"
      expect iri, "… has correct query"
        .has.ownProperty "query"
        .which.equals "b"
      expect iri, "… has correct fragment"
        .has.ownProperty "fragment"
        .which.equals "c"
