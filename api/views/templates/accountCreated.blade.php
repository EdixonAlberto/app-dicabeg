@php
    V2\Modules\EmailTemplate::$subject = 'Cuenta Activada';
@endphp

@extends('component.layout')

@section('content')

@component('component.content', [
        'imageName' => 'ok.png'
    ])
    @slot('content_first')
        <p>
            Has activado tu cuenta Dicabeg <strong>satisfactoriamente.</strong>
        </p>

        <hr />
        <p class="p-about">
            <strong>Dicabeg</strong> es una aplicación comprometida con <u>aumentar el poder adquisitivo del venezolano</u>, te recompensamos por hacer algo que esta unido a nuestra vida cotidiana, viendo publicidad generaras saldo <strong>dicag</strong>, el cual podrás cambiar por: accesorios para tu celular, teléfonos inteligente, desayunos, almuerzos entre otros.
        </p>

        <tr>
            <td id="td-portada" colspan="2">
                <img class="portada" src="{{ DATASERVER_URL }}/img/email/dicabeg_portada.png" alt="Portada de Dicabeg" />
                <h2><strong class="color">¡Bienvenid@ a Dicabeg!</strong></h2>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <p>
                    Si tienes alguna duda o consulta, recuerda que puedes escribirnos a <a href="mailto:{{ SUPPORT_EMAIL }}">{{ SUPPORT_EMAIL }}</a> con gusto te atenderemos.
                </p>
            </td>
        </tr>
    @endslot
@endcomponent

@endsection