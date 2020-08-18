<header>
  <div align="right">
    <b><cite>Eerie</cite></b><br />
    Source and Documentation<br />
    <code>README.md</code>
  </div>
  <hr />
  <div align="justify">
    <small>
      Copyright © 2018, 2020 Kyebego.
      Code released under GNU GPLv3 (or any later version);
        documentation released under CC BY-SA 4.0.
      For more information, see the license notice at the bottom of
        this document.
    </small>
  </div>
</header>

___

#  Eerie  #

>   Reference specifications:
>   + <https://tools.ietf.org/html/rfc3987>

An IRI parser, matching the ABNF specified in RFC3987.
Only tests well&#x2010;formedness, *not* validity.

Eerie targets RDF and similar applications where IRIs are being used as
  *identifiers*.
It does not include functionality for such things as IRI normalization,
  conversion, or resolution.
If you are working in a browser, you should use the browser's builtin
  URL capabilities for these tasks instead.

##  Usage  ##

This script provides a single constructor, which will attach itself to
  the `RFC3987` property on `self`/`window`/`exports`.
Calling with `new` is optional.
Pass in a string, and get an object back.

>   ```js
>   let iri = new RFC3987("http://📙.la/👀?!#wow")
>
>   iri.absolute
>   //  ⇒  "http://📙.la/👀?!"
>
>   iri.scheme
>   //  ⇒  "http"
>
>   iri.hierarchicalPart
>   //  ⇒  "//📙.la/👀"
>
>   iri.authority
>   //  ⇒  "📙.la"
>
>   iri.path
>   //  ⇒  "/👀"
>
>   iri.query
>   //  ⇒  "!"
>
>   iri.fragment
>   //  ⇒  "wow"
>
>   ```

For more information, see the annotated source below.

##  Annotated Source  ##

The remainder of this document gives the source code for Eerie.

###  Setup:

The following is just a regexification of the ABNF in RFC3987.

    iriRegex = ///  #  `IRI`
      ^
      (  #  `absoluteIRI` [= `absolute-IRI`]
        (  #  `scheme`
          [A-Za-z]
          [A-Za-z0-9+\-\.]*
        )
        :
        (  #  `ihierPart` [= `ihier-part`]
          //
          (  #  `iauthority`
            (?:
              (  #  `iuserinfo`
                (?:
                  [ 0-9A-Za-z\-\._~
                    \u00A0-\uD7FF
                    \uF900-\uFDCF
                    \uFDF0-\uFFEF
                    \u{10000}-\u{1FFFD}
                    \u{20000}-\u{2FFFD}
                    \u{30000}-\u{3FFFD}
                    \u{40000}-\u{4FFFD}
                    \u{50000}-\u{5FFFD}
                    \u{60000}-\u{6FFFD}
                    \u{70000}-\u{7FFFD}
                    \u{80000}-\u{8FFFD}
                    \u{90000}-\u{9FFFD}
                    \u{A0000}-\u{AFFFD}
                    \u{B0000}-\u{BFFFD}
                    \u{C0000}-\u{CFFFD}
                    \u{D0000}-\u{DFFFD}
                    \u{E0000}-\u{EFFFD}
                    !\$&'()*+,;=:
                  ] | %[0-9A-Fa-f]{2}
                )*
              )
              @
            )?
            (  #  `ihost`
              (  #  `IPLiteral` [= `IP-literal`]
                \[
                (  #  `IPv6address`
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){6}
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  )
                  | ::
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){5}
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){4}
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    )?
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){3}
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    ){0,2}
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){2}
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    ){0,3}
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  )
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    ){0,4}
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  (?:
                    [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                    | (?:
                      (?:
                        \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                        | 25[0-5]
                      )
                      \.
                    ){3}
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                  ) | (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    ){0,5}
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                  [0-9A-Fa-f]{1,4}
                  (?:
                    (?:
                      [0-9A-Fa-f]{1,4}
                      :
                    ){0,6}
                    [0-9A-Fa-f]{1,4}
                  )?
                  ::
                ) | (  #  `IPvFuture`
                  v
                  [0-9A-Fa-f]+
                  \.
                  [0-9A-Za-z\-\._~!\$&'()*+,;=:]+
                )
                \]
              ) | (  #  `IPv4address`
                (?:
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                  \.
                ){3}
                (?:
                  \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                  | 25[0-5]
                )
              ) | (  #  `iregName` [= `ireg-name`]
                (?:
                  [ 0-9A-Za-z\-\._~
                    \u00A0-\uD7FF
                    \uF900-\uFDCF
                    \uFDF0-\uFFEF
                    \u{10000}-\u{1FFFD}
                    \u{20000}-\u{2FFFD}
                    \u{30000}-\u{3FFFD}
                    \u{40000}-\u{4FFFD}
                    \u{50000}-\u{5FFFD}
                    \u{60000}-\u{6FFFD}
                    \u{70000}-\u{7FFFD}
                    \u{80000}-\u{8FFFD}
                    \u{90000}-\u{9FFFD}
                    \u{A0000}-\u{AFFFD}
                    \u{B0000}-\u{BFFFD}
                    \u{C0000}-\u{CFFFD}
                    \u{D0000}-\u{DFFFD}
                    \u{E0000}-\u{EFFFD}
                    !\$&'()*+,;=
                  ] | %[0-9A-Fa-f]{2}
                )*
              )
            )
            (?:
              :
              (  #  `port`
                \d*
              )
            )?
          )
          (  #  `ipathAbempty` [= `ipath-abempty`]
            (?:
              /
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=:@
                ] | %[0-9A-Fa-f]{2}
              )*
            )*
          )
        |
          (  #  `ipathAbsolute` [= `ipath-absolute`]
            /
            (?:
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=:@
                ] | %[0-9A-Fa-f]{2}
              )+
              (?:
                /
                (?:
                  [ 0-9A-Za-z\-\._~
                    \u00A0-\uD7FF
                    \uF900-\uFDCF
                    \uFDF0-\uFFEF
                    \u{10000}-\u{1FFFD}
                    \u{20000}-\u{2FFFD}
                    \u{30000}-\u{3FFFD}
                    \u{40000}-\u{4FFFD}
                    \u{50000}-\u{5FFFD}
                    \u{60000}-\u{6FFFD}
                    \u{70000}-\u{7FFFD}
                    \u{80000}-\u{8FFFD}
                    \u{90000}-\u{9FFFD}
                    \u{A0000}-\u{AFFFD}
                    \u{B0000}-\u{BFFFD}
                    \u{C0000}-\u{CFFFD}
                    \u{D0000}-\u{DFFFD}
                    \u{E0000}-\u{EFFFD}
                    !\$&'()*+,;=:@
                  ] | %[0-9A-Fa-f]{2}
                )*
              )*
            )?
          )
        |
          (  #  `ipathRootless` [= `ipath-rootless`]
            (?:
              [ 0-9A-Za-z\-\._~
                \u00A0-\uD7FF
                \uF900-\uFDCF
                \uFDF0-\uFFEF
                \u{10000}-\u{1FFFD}
                \u{20000}-\u{2FFFD}
                \u{30000}-\u{3FFFD}
                \u{40000}-\u{4FFFD}
                \u{50000}-\u{5FFFD}
                \u{60000}-\u{6FFFD}
                \u{70000}-\u{7FFFD}
                \u{80000}-\u{8FFFD}
                \u{90000}-\u{9FFFD}
                \u{A0000}-\u{AFFFD}
                \u{B0000}-\u{BFFFD}
                \u{C0000}-\u{CFFFD}
                \u{D0000}-\u{DFFFD}
                \u{E0000}-\u{EFFFD}
                !\$&'()*+,;=:@
              ] | %[0-9A-Fa-f]{2}
            )+
            (?:
              /
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=:@
                ] | %[0-9A-Fa-f]{2}
              )*
            )*
          ) | (  #  `ipathEmpty` [= `ipath-empty`]
          )
        )
        (?:
          \?
          (  #  `iquery`
            (?:
              [ 0-9A-Za-z\-\._~
                \u00A0-\uD7FF
                \uF900-\uFDCF
                \uFDF0-\uFFEF
                \u{10000}-\u{1FFFD}
                \u{20000}-\u{2FFFD}
                \u{30000}-\u{3FFFD}
                \u{40000}-\u{4FFFD}
                \u{50000}-\u{5FFFD}
                \u{60000}-\u{6FFFD}
                \u{70000}-\u{7FFFD}
                \u{80000}-\u{8FFFD}
                \u{90000}-\u{9FFFD}
                \u{A0000}-\u{AFFFD}
                \u{B0000}-\u{BFFFD}
                \u{C0000}-\u{CFFFD}
                \u{D0000}-\u{DFFFD}
                \u{E0000}-\u{EFFFD}
                !\$&'()*+,;=:@
                \uE000-\uF8FF
                \u{F0000}-\u{FFFFD}
                \u{100000}-\u{10FFFD}
                /?
              ] | %[0-9A-Fa-f]{2}
            )*
          )
        )?
      )
      (?:
        #{"#"}
        (  #  `ifragment`
          (?:
            [ 0-9A-Za-z\-\._~
              \u00A0-\uD7FF
              \uF900-\uFDCF
              \uFDF0-\uFFEF
              \u{10000}-\u{1FFFD}
              \u{20000}-\u{2FFFD}
              \u{30000}-\u{3FFFD}
              \u{40000}-\u{4FFFD}
              \u{50000}-\u{5FFFD}
              \u{60000}-\u{6FFFD}
              \u{70000}-\u{7FFFD}
              \u{80000}-\u{8FFFD}
              \u{90000}-\u{9FFFD}
              \u{A0000}-\u{AFFFD}
              \u{B0000}-\u{BFFFD}
              \u{C0000}-\u{CFFFD}
              \u{D0000}-\u{DFFFD}
              \u{E0000}-\u{EFFFD}
              !\$&'()*+,;=:@/?
            ] | %[0-9A-Fa-f]{2}
          )*
        )
      )?
      $
    ///u

There is a separate regex for relative IRIs:

    relativeRegex = ///  #  `irelativeRef` [= `irelative-ref`]
      ^
      (  #  `irelativePart` [= `irelative-part`]
        //
        (  #  `iauthority`
          (?:
            (  #  `iuserinfo`
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=:
                ] | %[0-9A-Fa-f]{2}
              )*
            )
            @
          )?
          (  #  `ihost`
            (  #  `IPLiteral` [= `IP-literal`]
              \[
              (  #  `IPv6address`
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                ){6}
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | ::
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                ){5}
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                ){4}
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  )?
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                ){3}
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){0,2}
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                ){2}
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){0,3}
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                (?:
                  [0-9A-Fa-f]{1,4}
                  :
                )
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){0,4}
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                (?:
                  [0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}
                  | (?:
                    (?:
                      \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                      | 25[0-5]
                    )
                    \.
                  ){3}
                  (?:
                    \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                    | 25[0-5]
                  )
                ) | (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){0,5}
                  [0-9A-Fa-f]{1,4}
                )?
                ::
                [0-9A-Fa-f]{1,4}
                (?:
                  (?:
                    [0-9A-Fa-f]{1,4}
                    :
                  ){0,6}
                  [0-9A-Fa-f]{1,4}
                )?
                ::
              ) | (  #  `IPvFuture`
                v
                [0-9A-Fa-f]+
                \.
                [0-9A-Za-z\-\._~!\$&'()*+,;=:]+
              )
              \]
            ) | (  #  `IPv4address`
              (?:
                (?:
                  \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                  | 25[0-5]
                )
                \.
              ){3}
              (?:
                \d | [1-9]\d | 1\d{2} | 2[0-4]\d
                | 25[0-5]
              )
            ) | (  #  `iregName` [= `ireg-name`]
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=
                ] | %[0-9A-Fa-f]{2}
              )*
            )
          )
          (?:
            :
            (  #  `port`
              \d*
            )
          )?
        )
        (  #  `ipathAbempty` [= `ipath-abempty`]
          (?:
            /
            (?:
              [ 0-9A-Za-z\-\._~
                \u00A0-\uD7FF
                \uF900-\uFDCF
                \uFDF0-\uFFEF
                \u{10000}-\u{1FFFD}
                \u{20000}-\u{2FFFD}
                \u{30000}-\u{3FFFD}
                \u{40000}-\u{4FFFD}
                \u{50000}-\u{5FFFD}
                \u{60000}-\u{6FFFD}
                \u{70000}-\u{7FFFD}
                \u{80000}-\u{8FFFD}
                \u{90000}-\u{9FFFD}
                \u{A0000}-\u{AFFFD}
                \u{B0000}-\u{BFFFD}
                \u{C0000}-\u{CFFFD}
                \u{D0000}-\u{DFFFD}
                \u{E0000}-\u{EFFFD}
                !\$&'()*+,;=:@
              ] | %[0-9A-Fa-f]{2}
            )*
          )*
        ) | (  #  `ipathAbsolute` [= `ipath-absolute`]
          /
          (?:
            (?:
              [ 0-9A-Za-z\-\._~
                \u00A0-\uD7FF
                \uF900-\uFDCF
                \uFDF0-\uFFEF
                \u{10000}-\u{1FFFD}
                \u{20000}-\u{2FFFD}
                \u{30000}-\u{3FFFD}
                \u{40000}-\u{4FFFD}
                \u{50000}-\u{5FFFD}
                \u{60000}-\u{6FFFD}
                \u{70000}-\u{7FFFD}
                \u{80000}-\u{8FFFD}
                \u{90000}-\u{9FFFD}
                \u{A0000}-\u{AFFFD}
                \u{B0000}-\u{BFFFD}
                \u{C0000}-\u{CFFFD}
                \u{D0000}-\u{DFFFD}
                \u{E0000}-\u{EFFFD}
                !\$&'()*+,;=:@
              ] | %[0-9A-Fa-f]{2}
            )+
            (?:
              /
              (?:
                [ 0-9A-Za-z\-\._~
                  \u00A0-\uD7FF
                  \uF900-\uFDCF
                  \uFDF0-\uFFEF
                  \u{10000}-\u{1FFFD}
                  \u{20000}-\u{2FFFD}
                  \u{30000}-\u{3FFFD}
                  \u{40000}-\u{4FFFD}
                  \u{50000}-\u{5FFFD}
                  \u{60000}-\u{6FFFD}
                  \u{70000}-\u{7FFFD}
                  \u{80000}-\u{8FFFD}
                  \u{90000}-\u{9FFFD}
                  \u{A0000}-\u{AFFFD}
                  \u{B0000}-\u{BFFFD}
                  \u{C0000}-\u{CFFFD}
                  \u{D0000}-\u{DFFFD}
                  \u{E0000}-\u{EFFFD}
                  !\$&'()*+,;=:@
                ] | %[0-9A-Fa-f]{2}
              )*
            )*
          )?
        ) | (  #  `ipathNoscheme` [= `ipath-noscheme`]
          (?:
            [ 0-9A-Za-z\-\._~
              \u00A0-\uD7FF
              \uF900-\uFDCF
              \uFDF0-\uFFEF
              \u{10000}-\u{1FFFD}
              \u{20000}-\u{2FFFD}
              \u{30000}-\u{3FFFD}
              \u{40000}-\u{4FFFD}
              \u{50000}-\u{5FFFD}
              \u{60000}-\u{6FFFD}
              \u{70000}-\u{7FFFD}
              \u{80000}-\u{8FFFD}
              \u{90000}-\u{9FFFD}
              \u{A0000}-\u{AFFFD}
              \u{B0000}-\u{BFFFD}
              \u{C0000}-\u{CFFFD}
              \u{D0000}-\u{DFFFD}
              \u{E0000}-\u{EFFFD}
              !\$&'()*+,;=@
            ] | %[0-9A-Fa-f]{2}
          )+
          (?:
            /
            (?:
              [ 0-9A-Za-z\-\._~
                \u00A0-\uD7FF
                \uF900-\uFDCF
                \uFDF0-\uFFEF
                \u{10000}-\u{1FFFD}
                \u{20000}-\u{2FFFD}
                \u{30000}-\u{3FFFD}
                \u{40000}-\u{4FFFD}
                \u{50000}-\u{5FFFD}
                \u{60000}-\u{6FFFD}
                \u{70000}-\u{7FFFD}
                \u{80000}-\u{8FFFD}
                \u{90000}-\u{9FFFD}
                \u{A0000}-\u{AFFFD}
                \u{B0000}-\u{BFFFD}
                \u{C0000}-\u{CFFFD}
                \u{D0000}-\u{DFFFD}
                \u{E0000}-\u{EFFFD}
                !\$&'()*+,;=:@
              ] | %[0-9A-Fa-f]{2}
            )*
          )*
        ) | (  #  `ipathEmpty` [= `ipath-empty`]
        )
      )
      (?:
        \?
        (  #  `iquery`
          (?:
            [ 0-9A-Za-z\-\._~
              \u00A0-\uD7FF
              \uF900-\uFDCF
              \uFDF0-\uFFEF
              \u{10000}-\u{1FFFD}
              \u{20000}-\u{2FFFD}
              \u{30000}-\u{3FFFD}
              \u{40000}-\u{4FFFD}
              \u{50000}-\u{5FFFD}
              \u{60000}-\u{6FFFD}
              \u{70000}-\u{7FFFD}
              \u{80000}-\u{8FFFD}
              \u{90000}-\u{9FFFD}
              \u{A0000}-\u{AFFFD}
              \u{B0000}-\u{BFFFD}
              \u{C0000}-\u{CFFFD}
              \u{D0000}-\u{DFFFD}
              \u{E0000}-\u{EFFFD}
              !\$&'()*+,;=:@
              \uE000-\uF8FF
              \u{F0000}-\u{FFFFD}
              \u{100000}-\u{10FFFD}
              /?
            ] | %[0-9A-Fa-f]{2}
          )*
        )
      )?
      (?:
        #{"#"}
        (  #  `ifragment`
          (?:
            [ 0-9A-Za-z\-\._~
              \u00A0-\uD7FF
              \uF900-\uFDCF
              \uFDF0-\uFFEF
              \u{10000}-\u{1FFFD}
              \u{20000}-\u{2FFFD}
              \u{30000}-\u{3FFFD}
              \u{40000}-\u{4FFFD}
              \u{50000}-\u{5FFFD}
              \u{60000}-\u{6FFFD}
              \u{70000}-\u{7FFFD}
              \u{80000}-\u{8FFFD}
              \u{90000}-\u{9FFFD}
              \u{A0000}-\u{AFFFD}
              \u{B0000}-\u{BFFFD}
              \u{C0000}-\u{CFFFD}
              \u{D0000}-\u{DFFFD}
              \u{E0000}-\u{EFFFD}
              !\$&'()*+,;=:@/?
            ] | %[0-9A-Fa-f]{2}
          )*
        )
      )?
      $
    ///u

An IRI reference can be either an IRI or a internationalized relative
  reference.

    regex = new RegExp "
      (?:#{iriRegex.source})|(?:#{relativeRegex.source})
    ", "u"

The helper function `splitPath()` splits the given path on `"/"`,
  ignoring any `"/"` characters which begin or end the string.

    splitPath = (path) ->
      return [] unless path?
      if path instanceof Array then Array::reduce.call path, (
        (result, current) ->
          result.push (splitPath current)...
          result
      ), []
      else
        path = do path.toString
        start = path.search /[^/]/
        end = (path.search /[^/]\/*$/) + 1
        return [] if start is -1 or end is -1
        String::split.call (path.substring start, end), "/"

###  The Constructor:

The `RFC3987()` constructor returns an object whose properties give the
  various components of the IRI, as strings.

The second argument to this constructor is optional, and controls
  behaviours regarding relative IRIs.
Namely: if it is `false`, then relative IRIs are forbidden, and if it
  is `true` then a relative IRI is required.
If it is `undefined` (or any other value), relative IRIs are neither
  required nor forbidden.

    RFC3987 = (iri, relative) ->
      if relative is yes
        error = "Relative IRI not well-formed under RFC3987."
      else if relative is no
        error = "IRI not well-formed under RFC3987."
      else error = "IRI reference not well-formed under RFC3987."
      throw new TypeError error unless iri?

Eerie tries to form an absolute IRI first, if possible.

      if relative isnt on and
        match = String::match.call iri, iriRegex then [
          IRI
          absoluteIRI
          scheme
          ihierPart
          iauthority
          iuserinfo
          ihost
          IPLiteral
          IPv6address
          IPvFuture
          IPv4address
          iregName
          port
          ipathAbempty
          ipathAbsolute
          ipathRootless
          ipathEmpty
          iquery
          ifragment
        ] = match

If an absolute IRI wasn't provided, then perhaps a relative one was
  instead.

      else if relative isnt off and
        match = String::match.call iri, relativeRegex
          [ irelativeRef
            irelativePart
            iauthority
            iuserinfo
            ihost
            IPLiteral
            IPv6address
            IPvFuture
            IPv4address
            iregName
            port
            ipathAbempty
            ipathAbsolute
            ipathNoscheme
            ipathEmpty
            iquery
            ifragment
          ] = match

If neither regex matches, that's an error.

      else throw new TypeError error

It is not required that `RFC3987()` be called as a constructor.

      result = (
        if @ instanceof RFC3987 then @ else Object.create RFC3987::
      )
      Object.defineProperties result,

###  Instance Properties:

####  `rfc3987.iri`.

The full IRI can be found on the `iri` property.
This is `undefined` for relative IRIs.
If you want a string value for an IRI reference without having to worry
  about whether it is absolute or relative, call `.toString()` instead.

        iri: value: IRI

####  `rfc3987.absolute`.

`absolute` holds the IRI, minus the fragment.

        absolute: value: absoluteIRI

####  `rfc3987.relative`.

`relative` holds the full relative IRI.
This is `undefined` for non&#2010;relative IRIs.

        relative: value: irelativeRef

####  `rfc3987.scheme`.

`scheme` holds the scheme of the IRI.

        scheme: value: scheme

####  `rfc3987.hierarchicalPart`.

`hierarchicalPart` holds the authority and/or path of the (possibly
  relative) IRI.

        hierarchicalPart: value: ihierPart ? irelativePart

####  `rfc3987.authority`.

`authority` holds the authority of the IRI, if present.

        authority: value: iauthority

####  `rfc3987.userinfo`.

`userinfo` holds the user of the IRI, if present.

        userinfo: value: iuserinfo

####  `rfc3987.host`.

`host` holds the host of the IRI, if present.

        host: value: ihost

####  `rfc3987.port`.

`port` holds the port of the IRI, if present.

        port: value: port

####  `rfc3987.path`.

`path` holds the path of the IRI.

        path: value: ipathAbempty ? ipathAbsolute ? (
          ipathRootless ? (ipathNoscheme ? ipathEmpty)
        )

####  `rfc3987.query`.

`query` holds the query of the IRI.
This does _not_ include the `?`.

        query: value: iquery

####  `rfc3987.fragment`.

`fragment` holds the fragment of the IRI.
This does _not_ include the `#`.

        fragment: value: ifragment

####  `rfc3987[n]`.

Subscripts give the hierarchical parts (authority and segments) of the
  URI in order.
This does not include the scheme, query, or fragment.

      parts = splitPath ihierPart ? irelativePart
      for part, index in parts
        Object.defineProperty result, index,
          enumerable: yes
          value: part

####  `rfc3987.length`.

`length` gives the number of hierarchical parts.

      Object.defineProperty result, "length", value: parts.length

###  The Prototype:

    Object.defineProperty RFC3987, "prototype",
      writable: no
      value: Object.defineProperties {},

###  Instance Methods:

####  `rfc3987.constructor()`.

`constructor()` is just the `RFC3987()` constructor.

        constructor: value: RFC3987

####  `rfc3987.toString()`.

The `toString()` method simply returns the `iri` as a string.

        toString: value: ->
          return "" unless @
          if typeof (value = @iri ? @relative)?.toString is "function"
            do value.toString
          else ""

####  `rfc3987.valueOf()`.

`valueOf()` will attempt to create a `URL` object, and return the
  string value of the IRI if unsuccessful.

        valueOf: value: ->
          return "" unless @
          if typeof URL is "function"
            try return new URL @iri ? @relative catch
          if typeof (iri = @iri ? @relative)?.toString is "function"
            do iri.toString
          else if typeof @toString is "function" then do @toString
          else ""

###  Constructor Properties:

####  Regexes.

The RFC3987 `iriRegex`, `relativeRegex`, and IRI reference `regex` are
  available as properties on the `RFC3987()` constructor itself.

        Object.defineProperties RFC3987,
          iriRegex:
            enumerable: yes
            value: regex
          relativeRegex:
            enumerable: yes
            value: regex
          regex:
            enumerable: yes
            value: regex

###  Constructor Methods:

####  `RFC3987.test(iri)`.

The `test()` function checks if a given string is a well-formed IRI
  reference, returning `true` or `false`.
If the second argument is `true` or `false`, this requires or forbids
  relative references

          test:
            enumerable: yes
            value: (iri, relative) -> (
              if relative is yes then relativeRegex
              else if relative is no then iriRegex
              else regex
            ).test iri

####  `RFC3987.testǃ(iri)`.

The `testǃ()` function does the same, but returns `undefined`, and
  throws an error if it is not.
If the second argument is `true` or `false`, this requires or forbids
  relative references

          testǃ:
            enumerable: yes
            value: (iri, relative) -> throw new TypeError "
              IRI not well-formed according to RFC3987.
            " unless (
              if relative is yes then relativeRegex
              else if relative is no then iriRegex
              else regex
            ).test iri

###  Availability:

Eerie's `RFC3987` constructor is defined on "the global object", which
  is the first of the following which is defined:

+ `self`
+ `window`
+ `exports`
+ `global`
^

    globalObject = self ? (window ? (exports ? (global ? null)))

It is an error if no global object could be found.

    throw new ReferenceError "
      Unknown global object.
    " unless globalObject?

Eerie targets vanilla ES 5.1, so it doesn't bother with modules or
  similar.
It simply attaches its constructor to the global object at
  `"RFC3987"`.
For the adventurous, you can also access the RFC3987 constructor from
  the emoji sequence `"👂👁"`.

    do ->
      EAR = "\u{1F442}"
      EYE = "\u{1F441}"
      Object.defineProperties globalObject,
        RFC3987:
          configurable: yes
          value: RFC3987
        "#{EAR}#{EYE}":
          configurable: yes
          value: RFC3987

###  Identity Information:

The global `RFC3987` constructor identifies itself using a number of
  properties, so that you can easily tell which version you are using
  (and so that you can build tools which support multiple versions!)

    Object.defineProperties RFC3987,

The `ℹ` property provides an identifying URI for the API author of this
  version of Eerie.
If you fork Eerie and change its API, you should also change this
  value.

      ℹ: value: "https://go.KIBI.family/Eerie/"

The `Nº` property provides the version number of this version of
  Eerie, as an object with three parts: `major`, `minor`, and
  `patch`.
It is up to the API author (identified above) to determine how these
  parts should be interpreted.
It is recommended that the `toString()` and `valueOf()` methods be
  implemented as well.

      Nº: value: Object.freeze
        major: 1
        minor: 0
        patch: 1
        toString: -> "#{@major}.#{@minor}.#{@patch}"
        valueOf: -> @major * 100 + @minor + @patch / 100

###  Dependencies:

`RFC3987` doesn't have any dependencies.
If it did, it would access them from the `context` property, which
  defaults to `self` or `window`.
This is only defined for compatibility with other scripts.

      context:
        writable: yes
        value: self ? (window ? {})

<footer>
  <details>
  <summary>License notice</summary>
  <p>This program is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version. Similarly, you can
    redistribute and/or modify the documentation sections of this
    document under the terms of the Creative Commons
    Attribution-ShareAlike 4.0 International License.</p>
  <p>This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
    General Public License for more details.</p>
  <p>You should have received copies of the GNU General Public License
    and the Creative Commons Attribution-ShareAlike 4.0 International
    License along with this source. If not, see
    https://www.gnu.org/licenses/ and
    https://creativecommons.org/licenses/by-sa/4.0/.</p>
  </details>
</footer>
