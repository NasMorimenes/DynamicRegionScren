ScanPixelPosition( xBits := 64 ) {
    static x64, x86

    if ( xBits != 64 ) {
        x86 :=
        (
            "VVdWU4tUJBSLdCQci0wkGItCCIt8JCCLXCQkOfAPho0AAAA5egwPhoQAAAAPr8eLEgHwvgEAAACLFIKJ0CX///8AOch0WTH2hNt0U4nPD"
            "7bricYPttLB7xDB/hAPtsSJ+w+2+yn+iffB/x8x/in+D7b5D7bNKfqJ18H/HzH6Kfo51g9N1inIicHB+R8xyCnIOcIPTcI5xQ+dwA+2w"
            "InGW4nwXl9dw412AI28JwAAAAC+/v///+vokJCQkJCQkJCQ"
        )
    }
    x64 :=
    (
        "i0EQRItUJChEOcAPhp8AAABEOUkUD4aVAAAARA+vyEiLAUUByEKLDIBBuAEAAACJyCX///8AOdB0aEUxwEWE0nRgRQ+2ykGJ0kGJwA+2y"
        "UHB6hBBwfgQD7bERQ+20kUp0EWJwkHB+h9FMdBFKdBED7bSD7bWRCnRQYnKQcH6H0Qx0UQp0UE5yEEPTcgp0Jkx0CnQOcEPTMhFMcBBO"
        "clBD53ARInAw2YuDx+EAAAAAABBuP7////r6pCQkJCQkJCQ"
    )

	return x64
}