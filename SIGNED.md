##### Signed by https://keybase.io/dberkom
```
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVOGDXAAoJEKU82t1CbYQMsX4P/3aONn4SK3HycxqxwYWf5kB5
wCIROdF6PS9z7N+toB/eXG2gkrAvVubygxSWARCUVFPMERYzGlAaNIpRC3J17UJJ
r0K8R4p85LX15GFYR384oOE/Fz58ZOSNp4CuzgGb0KE84Dlf0RaFAu7/4fEaj95T
tnHmQsD9vd3E+1cJKQcpak5H/q4QDqoiZOM08l9QHqd1Al17YDrnUXVeikhYlgkr
dHYqFVpzbKx6tNbxp5s1jmskqFivTifICHQUxbak7IMbagWsIhXo1v5yUaG4sFn2
DD565J/HGeNDFJtYTOUXQ5FQpaBlBfLeK0diAxL82sB52lSTyCTcKEtc9wGDQ9Th
8I3nAoAZSc7EE0t1mA+kKgJ5Aa4LIjK5LVaxFgGQNUQ8/0C38ZPqY+688qeSegjz
6g+aJCXfANLr4xMaUR/Vs8Ih+BIFx9HwrxBTWlx2k9SPwmoyfM6/ZUOATRIt/pc8
Rj+jsblToeTvfiCQYVnBSIhdVyAp8f6CJocxgxpWJTkJ+Z8TacHvdf9ne0guZv3x
SUpxPXnPySXKn4rTMOGBwVXEGpltoyH83LMnSoo10E+HZ2rw3wXhmRgmUFhfTMOM
W7GuH/hOgIpjBJwm6U58tdvvbVKxWqPs3YkI0wWQLZg7Egx3KfxxpwUZnhknTwL9
ulzks6YrsasuSLBIlnab
=K/b7
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
5819          README.md               dfa13635e784d6d1fd4e99fce3ec56ce966c837d8471ad8d4b2e96e278e55685
              config/                                                                                 
1030            config.exs            2d43b2f33a68081b675f8cedca5e74e5bdece4cd74258308326347b55ba85231
              lib/                                                                                    
                ex_twiml/                                                                             
2358              utilities.ex        f6a845359ee93103e05ad45d82e4e0bfa25864014026d725bdf37b28e18058da
6933            ex_twiml.ex           2e1bb4caa563c28793ff15776e4bc74d212deaa8480951b9047661d26053194f
1361          mix.exs                 a0aedfbcda72021d11797f63c619bd30f3702db48e37cedf2d72a3e9a07a6bc0
116           mix.lock                6b31484dd4497e4af5e378876479f5c22b067d71bde4d83120d6005932a9177b
              script/                                                                                 
622   x         release               3bf505bc77c52e4ff6618c63f5dc3cb176f636266abbf4aa9161d6222771663a
              test/                                                                                   
90              doc_test.exs          2393f6b1669c02b62328ff8c085c48d902b79fa787953b3fc065a4cb6b558af9
                ex_twiml/                                                                             
958               utilities_test.exs  7d66e9390afa1b42c8f6c951a24beed31b34f1410c8b62d313e8f640167f7ab5
5135            ex_twiml_test.exs     eb32de5ddfafd278e3ea66d60d917fdedcda039f2624379f930ce31e20879b07
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