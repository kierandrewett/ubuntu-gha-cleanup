const { readFileSync, writeFileSync } = require("fs");
const { resolve } = require("path")

const softwareRemoved = readFileSync(resolve(__dirname, "apt_remove.txt"), "utf-8")
const filesRemoved = readFileSync(resolve(__dirname, "files_remove.txt"), "utf-8")

let readme = readFileSync(resolve(__dirname, "README.md"), "utf-8");

console.log(softwareRemoved)

readme = readme.replace(readme.split('<!-- AUTOGEN:SOFTWARE_REMOVED:START -->').pop().split('<!-- AUTOGEN:SOFTWARE_REMOVED:END -->')[0], "")

readme = readme.replace("<!-- AUTOGEN:SOFTWARE_REMOVED:START -->", `<!-- AUTOGEN:SOFTWARE_REMOVED:START -->
## Software removed

**Total software removed**: ${softwareRemoved.split("\n").length}

<details>
  <summary>See all ${softwareRemoved.split("\n").length} items</summary>

  * ${softwareRemoved.split("\n").join("\n  * ")}

</details>

## Directories and files removed

**Total directories/files removed**: ${filesRemoved.split("\n").length}

<details>
  <summary>See all ${filesRemoved.split("\n").length} items</summary>

  * ${filesRemoved.split("\n").join("\n  * ")}

</details>
`)

console.log(readme)

writeFileSync(resolve(__dirname, "README.md"), readme)