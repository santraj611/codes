package org.example.stuff

fun nullability() {
    var lastName: String? = null
    // lastName = "Smith"

    // if (lastName != null) {
    //     println(lastName.length)
    // } else {
    //     println("Don't have a last name.")
    // }

    println(lastName?.length) // null

    lastName = "Smith"
    println(lastName?.length) // 5

    // lastName = null
    // println(lastName!!.length) // NullPointerException

    println(lastName!!.length) // 5


    // if lastName is not null then use the lastName but if it is
    // then use "SuperMan" as the superName
    lastName = null
    val superName: String = lastName ?: "SuperMan"
    println(superName) // SuperMan
}
