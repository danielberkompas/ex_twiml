##### Signed by https://keybase.io/dberkom
```
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVMYoOAAoJEKU82t1CbYQMUFsP/30Dyv+DQAeJigI4/2SdEsqZ
QK+EuqyY4rLlJiqnDAC6t7C1VRz4MM2SLc69tzi/Zmvcue82eizrkbafqkOiZvHS
EXIA3xelcPNjMdqnSzEo5t1EeiKjjrCEzJims8jRVoBdZL9TxHTiO6If43z5/09z
pzfq24rQaILb66nR344MDvh4Y879Db6/J4/9LOmHK6XJ63uhk6z2GdrSZru4+oMh
rpoBmTzsMGVJIme7u63UN1qcgWloEoXQayWEn1N2E4FgTeVbayZqoB3oPjDh+xC5
hazc0YM6Q9DbgiE3239QMrxcNF/98EvMn079G+laf5k8KyU+07fvfpKgEXj+P9eA
Xbl7CFs0aq7B0FHCZs7Ggygf8pco/uDtsvATACpYKfqvFvikvjw1pWVjsCqDjA/i
w4IkK3egytoi5gLOqDez5kCI4P0nq7pf/FOiKeTwmvb0/b/4Mb8ZUiftdnw7/84/
IHQWOAnhKgtcxBB2tatotwNWvD6pkecLdaWJYAGV4rmjWvdWxQN0Aar5KrjRKjIC
0dz4WeoTqfHERRD4XlmBohCUP/LNo1b/RReMlOiyTZzPZyx9H7f1cptz6+Q02Z7t
+r1F2RV7SYMzJNp6xwpA5S3LWet7hEO8xx+UllNMLtBdK5VfXViPs5Qsrmd0j623
x75cYEQx5znC5OTuzvRl
=QDqY
-----END PGP SIGNATURE-----

```

<!-- END SIGNATURES -->

### Begin signed statement 

#### Expect

```
size  exec  file                      contents                                                        
            ./                                                                                        
39            .gitignore              eb960262e9265b73031d4ee9063d2cd537cfcb33629a422bcb94367609ae1c4d
619           .travis.yml             34067725317b027149862d11a95ffe3adc6b92e1b455c0c49fff8de54d74439b
153           CHANGELOG.md            42e628018fccb4a446a68c506c2e9437df5eb0ab0071c89cf4248f2dc3a398d6
1083          LICENSE                 a24b375a609f6c84e82c1458fbb0383678e3f492ffb83912731fa5313831a7c9
322           NOTICE                  9b9f53c89cde0e23ea4f718683e5f76d576d8129dc4a5b3d2597128bc61024ad
5819          README.md               b17142c3f7575e8aa041c3bc405b929133420f806733dbdfc9898d7375289892
              config/                                                                                 
1030            config.exs            2d43b2f33a68081b675f8cedca5e74e5bdece4cd74258308326347b55ba85231
              lib/                                                                                    
                ex_twiml/                                                                             
2358              utilities.ex        f6a845359ee93103e05ad45d82e4e0bfa25864014026d725bdf37b28e18058da
6915            ex_twiml.ex           67b708352c0dd03f19223314d872d41aef51b25b10cfc24b7302ffc7d850ef28
1361          mix.exs                 94f8185ab425978f0592f875d208f5bb936e967092fa2ea5d60adf1fc12fa26f
116           mix.lock                6b31484dd4497e4af5e378876479f5c22b067d71bde4d83120d6005932a9177b
              script/                                                                                 
622   x         release               3bf505bc77c52e4ff6618c63f5dc3cb176f636266abbf4aa9161d6222771663a
              test/                                                                                   
90              doc_test.exs          2393f6b1669c02b62328ff8c085c48d902b79fa787953b3fc065a4cb6b558af9
                ex_twiml/                                                                             
958               utilities_test.exs  7d66e9390afa1b42c8f6c951a24beed31b34f1410c8b62d313e8f640167f7ab5
4922            ex_twiml_test.exs     6944a01ede88926c79d8b76c3017c70502196a826e2967c8671ec6b66b09d19c
15              test_helper.exs       b086ec47f0c6c7aaeb4cffca5ae5243dd05e0dc96ab761ced93325d5315f4b12
```

#### Ignore

```
/SIGNED.md
```

#### Presets

```
git      # ignore .git and anything as described by .gitignore files
dropbox  # ignore .dropbox-cache and other Dropbox-related files    
kb       # ignore anything as described by .kbignore files          
```

<!-- summarize version = 0.0.9 -->

### End signed statement

<hr>

#### Notes

With keybase you can sign any directory's contents, whether it's a git repo,
source code distribution, or a personal documents folder. It aims to replace the drudgery of:

  1. comparing a zipped file to a detached statement
  2. downloading a public key
  3. confirming it is in fact the author's by reviewing public statements they've made, using it

All in one simple command:

```bash
keybase dir verify
```

There are lots of options, including assertions for automating your checks.

For more info, check out https://keybase.io/docs/command_line/code_signing