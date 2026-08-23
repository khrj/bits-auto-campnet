package com.khushrajrathod.autocampnet

@kotlinx.serialization.Serializable
data class Settings(
    val credSet: Boolean = false,
    val qsAdded: Boolean = false,
    val service: Boolean = false,
    val address: Int = 0,
    val username: String = "",
    val password: String = ""
)
