$(document).ready(function(){

    $('select').material_select();
    $('.modal').modal();

    $('.scrollspy').scrollSpy();
    $('.datepicker').pickadate(
        {

            format: 'dd/mm/yyyy'

        });

    $('.fixed').pushpin({
        top: 0,
        bottom: 1500,
        offset: 0,
        padding-left: 555

    });


});