package com.khushrajrathod.autocampnet

import android.content.Context
import android.net.Network
import com.android.volley.Request
import com.android.volley.RequestQueue
import com.android.volley.toolbox.HurlStack
import com.android.volley.toolbox.Volley
import java.net.HttpURLConnection
import java.net.URL

// Opens every connection through the given Network explicitly instead of
// whatever Android currently treats as the "default" network. A Wi-Fi
// network stuck behind a captive portal isn't "validated", so once a
// mobile data connection is also up, the OS routes the default network
// (and therefore a plain HttpURLConnection) over data instead of Wi-Fi -
// meaning the login request never reaches the captive portal, which is
// often only reachable from the Wi-Fi network to begin with.
private class NetworkBoundHurlStack(private val network: Network) : HurlStack() {
    override fun createConnection(url: URL): HttpURLConnection =
        network.openConnection(url) as HttpURLConnection
}

class VolleySingleton private constructor(private val context: Context) {
    companion object {
        @Volatile
        private var INSTANCE: VolleySingleton? = null
        var isEmpty = true
        fun getInstance(context: Context) =
            INSTANCE ?: synchronized(this) {
                INSTANCE ?: VolleySingleton(context.applicationContext).also {
                    INSTANCE = it
                }
            }
    }

    @Volatile
    private var requestQueue: RequestQueue? = null

    // A fresh queue is created per attempt and bound to the Wi-Fi Network
    // handed to us by ConnectivityManager.requestNetwork's onAvailable
    // callback, since that Network instance is only valid for this one
    // Wi-Fi connection and can't be reused across reconnects.
    @Synchronized
    fun <T> addToRequestQueue(req: Request<T>, network: Network) {
        isEmpty = false
        requestQueue?.stop()
        requestQueue = Volley.newRequestQueue(context, NetworkBoundHurlStack(network)).also {
            it.add(req)
        }
    }

    fun cancelAll() {
        isEmpty = true
        requestQueue?.cancelAll { true }
    }
}
