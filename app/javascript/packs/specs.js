// First load your regular JavaScript (copy all the JavaScript imports from your main pack).
let webpackContext = require.context('../../javascript', true, /\.js(\.erb)?$/)
for(let key of webpackContext.keys()) { webpackContext(key) }

// Then load the specs
let specsContext = require.context('../spec', true, /\.js(\.erb)?$/)
for(let key of specsContext.keys()) { specsContext(key) }
