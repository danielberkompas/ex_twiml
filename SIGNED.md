##### Signed by https://keybase.io/dberkom
```
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVOX3OAAoJEKU82t1CbYQM96sP/3D21BGVPRi0qCvtkssew8iM
xKB0okpWupnYOdI2XT2ncohIx0Zse1ed0ZVnBh8EX6jQ+dccKdg6G2vGA+tCyNFe
DF9JmkNYrl95WCk7R7r9+qppqJdQU4VeSHN+HadYjkFbEp0A/3bgi+mpM1lE2SBY
VsAZ+cUVcBwwS1RkSswuK7dNq05FSuXhu73+Of/rLEUEi65JE15XQwplZwW8VSc0
RDEeMp/2A9bNZUdCyUbanOntXuO6hPmPu80ybPazrXXUhetDRYs9RqSsHNJtdoCg
T1EYi5HetgMPmQXnM7fq8Q/qeb0+GC7c47Ss5MC8FayK3/zW26XNguduUF/Jxhu1
SGYspilG/f3C546nGPtV5NvDYysZEFSWWTkhxMfsnN7IRPFE1niGwb6EUvLc1Pip
tQ5FvD7hq9Pd1btILwDjYG7moZkKxTMfcbXMnRVQvrvTFEZGy/yVpl5ugsbaOz/j
+2OX6ot8RmfumO+J3fis5mPUX6xkrwFp0qvqdAfiaRCXkkQh3yw9MQbJcZ3lvWhu
ThxCixAGNIeM6IBkGLEs7DRGmDNyGK2g2hO3rOWLQZe3fDOGREOSKhj7noYwbiBc
agWCmc+5eZxI/RkJkyf9GDKj6wXKoSYXGgbyRUyrk6ZtxLsCUn+UG2NpQuthbyyY
3C2HNeKndpgOpu+hwglO
=lb5W
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
5819          README.md               70513755e3dee588381458942688fb9197d97d1067d5bae382ecd2d8f3ad3840
              config/                                                                                 
1030            config.exs            2d43b2f33a68081b675f8cedca5e74e5bdece4cd74258308326347b55ba85231
              lib/                                                                                    
                ex_twiml/                                                                             
2358              utilities.ex        f6a845359ee93103e05ad45d82e4e0bfa25864014026d725bdf37b28e18058da
6939            ex_twiml.ex           449dbe7fe2ff225903e3382224aac93ea3797460fe0d8900e831ef4390e2c72c
1361          mix.exs                 a9ad264a8dcc1bace71da3411f863c2e64158994ba9b1ad7a605143a8522e8d9
116           mix.lock                6b31484dd4497e4af5e378876479f5c22b067d71bde4d83120d6005932a9177b
              script/                                                                                 
622   x         release               3bf505bc77c52e4ff6618c63f5dc3cb176f636266abbf4aa9161d6222771663a
              test/                                                                                   
90              doc_test.exs          2393f6b1669c02b62328ff8c085c48d902b79fa787953b3fc065a4cb6b558af9
                ex_twiml/                                                                             
958               utilities_test.exs  7d66e9390afa1b42c8f6c951a24beed31b34f1410c8b62d313e8f640167f7ab5
5345            ex_twiml_test.exs     ef31860bdbb31ad2524832b7387a01b5916d0e35cd7d7d1347ab8d6ad31591bd
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