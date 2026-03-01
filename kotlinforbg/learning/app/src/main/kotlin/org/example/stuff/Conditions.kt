package org.example.stuff

fun conditions() {
    val a = 5
    val b = 2

    println("a + b = ${a + b}")
    println("a - b = ${a - b}")
    println("a * b = ${a * b}")
    println("a / b = ${a / b}")
    println("a % b = ${a % b}")

    var result = a + b

    result += 2
    println("result: $result")
    result -= 2
    println("result: $result")
    result *= 2
    println("result: $result")
    result /= 2
    println("result: $result")
    result %= 2
    println("result: $result")

    val isGenZ = true
    if (isGenZ) {
        println("Are you cool man?")
    } else {
        println("I don't know what to say?")
    }

    val temp = 30
    if (temp > 40) {
        println("Damn, It's hot!")
    } else if (temp <= 15) {
        println("Damn, I am so cold!")
    } else {
        println("It's nice out here!")
    }

    val isPlayerAlive = true
    val playerScore = 1032
    if (isPlayerAlive && playerScore > 1000) {
        println("Level Up!")
    } else {
        println("Try Again!")
    }

    val condOne = true
    val condTwo = false
    if (condOne || condTwo) {
        println("Either one or more conditions are true!")
    } else {
        println("Both conditions are false!")
    }

    // only two genders exist in this game
    var isPlayerMale = false
    var playerGender = if (isPlayerMale) {
        "Male"
    } else {
        "Female"
    }
    println("Player is $playerGender")

    // also can go one liner
    isPlayerMale = true
    playerGender = if (isPlayerMale) "Male" else "Female"
    println("Player is $playerGender")


    // switch/when conditions
    when (val smallPrime = 13) {
        1, 2, 3, 5, 7 -> println("$smallPrime is a small prime number.")
        11 -> println("$smallPrime is a small prime number.")
        13, 15 -> println("$smallPrime is a small prime number.")
        else -> println("$smallPrime is a prime number")
    }

    when (val smallNumber = 4) {
        0 -> println("I am zero.")
        in 1..10 -> println("I am greater than zero and less than 10.")
        else -> println("I am greater than 10.")
    }

}
