$(() => {
    const navBarLinks = [
        {}
    ];
});


function mostrarNotificacao(titulo, mensagem, tipoNotificacao)
{
    iziToast.show({
        id: null,
        class: '',
        title: titulo,
        titleColor: '#000',
        titleSize: '',
        titleLineHeight: '',
        message: mensagem,
        messageColor: '#000',
        messageSize: '',
        messageLineHeight: '',
        backgroundColor: '',
        theme: 'dark', // dark
        color: tipoNotificacao == 'sucesso' ? 'green' : 'red', // blue, red, green, yellow
        icon: '',
        iconText: '',
        iconColor: '',
        iconUrl: null,
        image: '',
        imageWidth: 50,
        maxWidth: null,
        zindex: null,
        layout: 2,
        balloon: false,
        close: true,
        closeOnEscape: false,
        closeOnClick: false,
        displayMode: 0, // once, replace
        position: 'bottomCenter', // bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter, center
        target: '',
        targetFirst: true,
        timeout: 10000,
        rtl: false,
        animateInside: true,
        drag: true,
        pauseOnHover: true,
        resetOnHover: false,
        progressBar: true,
        progressBarColor: '',
        progressBarEasing: 'linear',
        overlay: true,
        overlayClose: true,
        overlayColor: 'rgba(0, 0, 0, 0.6)',
        transitionIn: 'fadeInUp',
        transitionOut: 'fadeOut',
        transitionInMobile: 'fadeInUp',
        transitionOutMobile: 'fadeOutDown',
        buttons: {},
        inputs: {},
        onOpening: function () { },
        onOpened: function () { },
        onClosing: function () { },
        onClosed: function () { }
    });
}

