##### Signed by https://keybase.io/dberkom
```
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVKbWVAAoJEKU82t1CbYQMr8wQAJ1fndKg74VCngdm7P6VC4+w
zfclxFW1xU9VZPsmSxD5B0IV1IiXobGeJEJmbd6srUIGUCmjw3iryS2M3sU3yUde
xlm6l1mJH5tn+Q/MzOWQKwiWphEQ2ReWmaCSrU6CA7Fqe5SH+2638vc6h+zlyQct
zmJ8y7v2PYPlb+v4cLtNNJl0wmdH8ltgDx9QDUQ+aj2Spdxll2/D0MaHWf9bEORq
RmQaYdshd//NOZC28eS/IeSbVGx3MqK6+VcpxCknnFaVdibxLbtiBnr91VxHdvkE
IkcB+tFsktUH5JKOMaO/KKHjCg3q7NJxylVx8ynMGMv1/Tv4/Gm+G5jlWcg8fg7C
Ycy3yudQihbtTunTFR5MhMDBRFjHboU6y3kk2jtiE/Ht/lRmjmJJsuGrTpWZGpgF
BIDEAInpWuYhXdfGMuJrK169kjYQmh7px4gG6Wq3oiAcThxNpMjWE++Dkrq8dSuo
zzF9TtfTxwF7b79OCVtJ2TDuU9YqaP+MjXhMfzJhsDc1Ml/tRi2SInOpjvSHgHGu
TSnYWOfHnNYojpnXF9hbcWNjNJFdL1KVBEwMDEq2WuGTVVkDNo053K3vVN1i5C6+
C5dcyfmkof0oI19pM43sYfRT7osC5We2bWbRdcVpb7T1h6efhKa8jkCIxvdARCVb
AF/iJImRAVgvfs6ghlWH
=SR2t
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
700           CHANGELOG.md            8a63945a8c08bfc63707da2954af96c873ae01e6f1f4db075ae3edd7ba6dd799
1083          LICENSE                 a24b375a609f6c84e82c1458fbb0383678e3f492ffb83912731fa5313831a7c9
322           NOTICE                  9b9f53c89cde0e23ea4f718683e5f76d576d8129dc4a5b3d2597128bc61024ad
5819          README.md               4445c7cb8cd72988ffa058edd3f5e10149f8f097b3ccbbcb652c395e495e9e92
              config/                                                                                 
1030            config.exs            2d43b2f33a68081b675f8cedca5e74e5bdece4cd74258308326347b55ba85231
              lib/                                                                                    
                ex_twiml/                                                                             
2358              utilities.ex        f6a845359ee93103e05ad45d82e4e0bfa25864014026d725bdf37b28e18058da
6732            ex_twiml.ex           ae4cd472c6ab45ed072355807ea410682668b143a7d616d4103828d14cfb6ac9
1361          mix.exs                 404cdd46ca0e707387355e03d78ea07fd23018495e3e3be5bbf3909517d5cdce
116           mix.lock                6b31484dd4497e4af5e378876479f5c22b067d71bde4d83120d6005932a9177b
              script/                                                                                 
622   x         release               3bf505bc77c52e4ff6618c63f5dc3cb176f636266abbf4aa9161d6222771663a
              test/                                                                                   
90              doc_test.exs          2393f6b1669c02b62328ff8c085c48d902b79fa787953b3fc065a4cb6b558af9
                ex_twiml/                                                                             
958               utilities_test.exs  7d66e9390afa1b42c8f6c951a24beed31b34f1410c8b62d313e8f640167f7ab5
4611            ex_twiml_test.exs     5e61e060da643c1e2b9d9ea542f64f2118a8e2adac88b838c2d16d93c5ec9efa
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