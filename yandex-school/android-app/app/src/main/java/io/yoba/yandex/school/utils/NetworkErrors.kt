package io.yoba.yandex.school.utils

import retrofit2.HttpException
import java.io.IOException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

sealed class NetworkError {
    class BadFormat : NetworkError()
    class Unauthorized : NetworkError()
    class TooManyRequests : NetworkError()
    class ServerIsUnavailable : NetworkError()
    class PayloadTooLarge : NetworkError()
    class PermissionDenied : NetworkError()
    class NotFound : NetworkError()
    class BadGateway : NetworkError()
    class NoInternetConnection : NetworkError()
    class Timeout : NetworkError()
    class Unknown : NetworkError()
}

fun mapResponseCodeToException(responseCode: Int): NetworkError {
    return when (responseCode) {
        400 -> NetworkError.BadFormat()
        401 -> NetworkError.Unauthorized()
        403 -> NetworkError.PermissionDenied()
        404 -> NetworkError.NotFound()
        413 -> NetworkError.PayloadTooLarge()
        429 -> NetworkError.TooManyRequests()
        500 -> NetworkError.ServerIsUnavailable()
        502 -> NetworkError.BadGateway()
        else -> NetworkError.Unknown()
    }
}

fun mapThrowableToNetworkError(e: Throwable): NetworkError {
    return when (e) {
        is HttpException -> mapResponseCodeToException(e.code())
        is UnknownHostException,
        is IOException -> NetworkError.NoInternetConnection()
        is SocketTimeoutException -> NetworkError.Timeout()
        else -> NetworkError.Unknown()
    }
}