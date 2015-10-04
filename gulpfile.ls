require! {
  livescript

  gulp
  'gulp-util': gutil
  'gulp-mocha': mocha
}


gulp.task \default, <[ test ]>
gulp.task \test, <[ mocha ]>

gulp.task \mocha ->
  gulp.src <[ test/*.ls ]>, read: false
    .pipe mocha( reporter: \spec )
