# This is a manifest file that'll be compiled into job_board.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery-pjax/jquery.pjax

$(document).pjax 'a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])', '[data-pjax-container]'
