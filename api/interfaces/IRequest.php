<?php

namespace V2\Interfaces;

interface IRequest
{
    const METHODS = ['GET', 'PUT', 'POST', 'PATCH', 'DELETE'];

    const HEADERS = ['ACCESS_TOKEN', 'REFRESH_TOKEN'];
}
