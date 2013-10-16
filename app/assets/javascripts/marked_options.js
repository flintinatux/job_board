marked.setOptions({
  gfm: true,
  // highlight: function (code, lang, callback) {
  //   pygmentize({ lang: lang, format: 'html' }, code, function (err, result) {
  //     if (err) return callback(err);
  //     callback(null, result.toString());
  //   });
  // },
  tables: false,
  breaks: true,
  pedantic: false,
  sanitize: true,
  smartLists: true,
  smartypants: false
  // langPrefix: 'lang-'
});
