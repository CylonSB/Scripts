# Template

This folder is a template for scripts. To add a new script to the library copy this folder, rename it and modify the files.

Every folder **must** contain:
- A `README.md` file (like this one) which explains what the script is for and how to use it
- One or more `.yolol` files containing the script. These **must** be valid yolol (checked by [this](https://dbaumgarten.github.io/yodk/#/cli?id=verification) tool).
- Working test-cases for the yolol-code in files called ```*test.yaml```. The format for the test is defined [here](https://dbaumgarten.github.io/yodk/#/cli?id=testing)

You **may** include:
- A `Development.md` file with extra technical notes about the script which may be helpful for other developers attempting to extend or modify the script.
- A `License.md` file with the license for all content in this folder. If not specified license is assumed to be [CC0](https://creativecommons.org/share-your-work/public-domain/cc0/).
- `.nolol` files from which the .yolol files were compiled. These will also be checked for correctness.

### Inputs

After the introduction, which explains what the script does, you should include details about every input the script reads and every output the script writes. For example:

 - `:b`: A number
 - `:c`: A number

### Outputs

 - `:a`: The sum of `:b` and `:c`

### Credits

You may include a section crediting the developers involved in writing the script. e.g.

 - Martin Evans (Discord: Martin#2468 aka Yolathothep)
