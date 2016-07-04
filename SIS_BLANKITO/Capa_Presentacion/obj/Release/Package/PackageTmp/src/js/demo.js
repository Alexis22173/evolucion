$(document).ready(function(){
    //Welcome Message (not for login page)
    function notify(message, type){
        $.growl({
            message: message
        },{
            type: type,
            allow_dismiss: false,
            label: 'Cancel',
            className: 'btn-xs btn-inverse',
            placement: {
                from: 'top',
                align: 'right'
            },
            delay: 2500,
            animate: {
                    enter: 'animated bounceIn',
                    exit: 'animated bounceOut'
            },
            offset: {
                x: 20,
                y: 85
            }
        });
    };
    
    var url = window.location.pathname.split("/");
    url = url[url.length - 1];
    if (url.indexOf("Inicio.") != -1 ) {
        notify('Bienvenido de nuevo Mallinda Hollaway', 'inverse');
    } 
});