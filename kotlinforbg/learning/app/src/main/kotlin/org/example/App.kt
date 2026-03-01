package org.example

import org.example.stuff.conditions
import org.example.stuff.nullability

fun main() {
    var usrName = "Alex" // Auto type inference
    usrName = "John"
    // usrName = 123 // Error

    val usrAge = 20

    println("Hello, $usrName!")
    println("You are $usrAge years old.")

    // Byte (8 bit)
    val maxByte: Byte = Byte.MAX_VALUE
    val minByte: Byte = Byte.MIN_VALUE
    println("Max byte: $maxByte")
    println("Min byte: $minByte")

    // Short (16 bit)
    val maxShort: Short = Short.MAX_VALUE
    val minShort: Short = Short.MIN_VALUE
    println("Max Short: $maxShort")
    println("Min Short: $minShort")

    // Int (32 bit)
    val maxInteger: Int = Int.MAX_VALUE
    val minIneger: Int = Int.MIN_VALUE
    println("Max integer: $maxInteger")
    println("Min integer: $minIneger")

    // Long (64 bit)
    val maxLong: Long = Long.MAX_VALUE
    val minLong: Long = Long.MIN_VALUE
    println("Max long: $maxLong")
    println("Min long: $minLong")

    // float (32 bit)
    val maxFloat: Float = Float.MAX_VALUE
    val minFloat: Float = Float.MIN_VALUE
    println("Max float: $maxFloat")
    println("Min float: $minFloat")

    // double (64 bit)
    val maxDouble: Double = Double.MAX_VALUE
    val minDouble: Double = Double.MIN_VALUE
    println("Max double: $maxDouble")
    println("Min double: $minDouble")

    // char
    val group: Char = 'S'
    println("Group: $group")

    // boolean
    val isGenZ: Boolean = true
    println("Is Gen Z: $isGenZ")

    // call the Conditions.kt file from subpackage `stuff`
    conditions()
    // call the Nullability.kt file from subpackage `stuff`
    nullability()
}
