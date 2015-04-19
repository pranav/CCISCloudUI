var gulp = require('gulp'),
    gutil = require('gulp-util'),
    sass = require('gulp-sass'),
    livereload = require('gulp-livereload'),
    coffee = require('gulp-coffee'),
    connect = require('gulp-connect'),
    historyApiFallback = require('connect-history-api-fallback'),
    webserver = require('gulp-webserver')


gulp.task('styles', function() {
   gulp.src('./src/scss/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./dist/css/'))
        .pipe(connect.reload())
})

gulp.task('coffee', function() {
    gulp.src('./src/coffee/**')
        .pipe(coffee())
        .pipe(gulp.dest('dist/js/'))
        .pipe(connect.reload())
})

gulp.task('html', function() {
    gulp.src('./src/html/**')
        .pipe(gulp.dest('dist/html'))
        .pipe(connect.reload())
})

gulp.task('third-party', function() {
    gulp.src('./src/third-party/angular/angular.js')
        .pipe(gulp.dest('dist/third-party/angular/'))

    gulp.src('./src/third-party/angular-route/angular-route.min.js')
        .pipe(gulp.dest('dist/third-party/angular-route/'))

    gulp.src('./src/third-party/angular-resource/angular-resource.min.js')
        .pipe(gulp.dest('dist/third-party/angular-resource/'))

    gulp.src('./src/third-party/bootstrap/dist/**')
        .pipe(gulp.dest('dist/third-party/bootstrap/'))

    gulp.src('./src/third-party/jquery/dist/**')
        .pipe(gulp.dest('dist/third-party/jquery/'))
})

connectOptions = {
    host: '127.0.0.1',
    livereload: false,
    fallback: 'html/index.html',
    proxies: [
        { source: '/api/v1/', target: 'http://127.0.0.1:5000/api/v1/'}
    ]
}
gulp.task('webserver', function() {
    gulp.src('dist')
        .pipe(webserver(connectOptions))
})

gulp.task('watch', function(){
    gulp.watch(['./src/**'], ['html', 'styles', 'coffee', 'third-party'])
})

