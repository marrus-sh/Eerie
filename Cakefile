{ build, clear, configure, watch } = require 'Roost'

#  See <https://go.KIBI.family/Roost/> for the meaning of this
#    configuration.
configure
  destination: "Build/"
  literate: yes
  name: "Eerie"
  order: [ "README" ]
  preamble: "README.js"
  prefix: ""
  suffix: ".md"

task "build", "build Eerie", build
task "watch", "build Eerie and watch for changes", watch
task "clear", "remove built files", clear
