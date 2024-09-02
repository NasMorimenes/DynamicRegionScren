; Calcula o ângulo de matiz (hue angle)
GetHueAngle(a, b) {
    if a = 0
        return 90

    static pi := 3.141592653589793
    h := (180 / pi) * ATan(b / a)

    if a > 0 and b > 0
        return h
    else if a < 0 and b > 0
        return 180 + h
    else if a < 0 and b < 0
        return 180 + h
    else
        return 360 + h
}