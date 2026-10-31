const sass = require("sass");

module.exports = function (eleventyConfig) {
  eleventyConfig.addTemplateFormats("scss");
  eleventyConfig.addExtension("scss", {
    outputFileExtension: "css",
    compile: async function (inputContent) {
      return async () => sass.compileString(inputContent, {
        loadPaths: ["_sass"],
        style: "compressed",
      }).css;
    },
  });

  eleventyConfig.addWatchTarget("_sass");

  eleventyConfig.addPassthroughCopy({
    assets: "assets",
  });

  return {
    dir: {
      input: "src",
      includes: "_includes",
      layouts: "_layouts",
      data: "_data",
      output: "_site-eleventy",
    },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
  };
};
