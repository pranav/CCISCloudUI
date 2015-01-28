var gulp = require('gulp'),
    gutil = require('gulp-util'),
    sass = require('gulp-sass'),
    livereload = require('gulp-livereload'),
    coffee = require('gulp-coffee'),
    connect = require('gulp-connect')

connectOptions = { root: 'dist', livereload: true}

gulp.task('styles', function() {
   gulp.src('./src/scss/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./dist/css/'))
        .pipe(connect.reload())
})

gulp.task('coffee', function() {
    gulp.src('./src/coffee/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('dist/js/'))
        .pipe(connect.reload())
})

gulp.task('html', function() {
    gulp.src('./src/html/*.html')
        .pipe(gulp.dest('dist/html'))
        .pipe(connect.reload())
})

gulp.task('third-party', function() {
    gulp.src('./src/third-party/angular/angular.js')
        .pipe(gulp.dest('dist/third-party/angular/angular.js'))

    gulp.src('./src/third-party/bootstrap/dist/**')
        .pipe(gulp.dest('dist/third-party/bootstrap/'))

    gulp.src('./src/third-party/jquery/dist/**')
        .pipe(gulp.dest('dist/third-party/jquery/'))
})

gulp.task('connect', function() {connect.server(connectOptions)})

gulp.task('watch', function(){
    gulp.watch(['./src/**'], ['html', 'styles', 'coffee', 'third-party'])
    connect.server(connectOptions)
})

